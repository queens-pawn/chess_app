class Game < ActiveRecord::Base
  has_many :pieces
  #after_create :populate_board!

  def populate_board!
    (0..7).each do |y|
      Piece.create(:type => 'Pawn', :color => 'black', :game_id => id, :x_position => y, :y_position => 1)
    end
    Piece.create(:type => 'Rook', :color => 'black', :game_id => id, :x_position => 0, :y_position => 0)
    Piece.create(:type => 'Rook', :color => 'black', :game_id => id, :x_position => 7, :y_position => 0)

    Piece.create(:type => 'Knight', :color => 'black', :game_id => id, :x_position => 1, :y_position => 0)
    Piece.create(:type => 'Knight', :color => 'black', :game_id => id, :x_position => 6, :y_position => 0)

    Piece.create(:type => 'Bishop', :color => 'black', :game_id => id, :x_position => 2, :y_position => 0)
    Piece.create(:type => 'Bishop', :color => 'black', :game_id => id, :x_position => 5, :y_position => 0)

    Piece.create(:type => 'King', :color => 'black', :game_id => id, :x_position => 4, :y_position => 0)
    Piece.create(:type => 'Queen', :color => 'black', :game_id => id, :x_position => 3, :y_position => 0)

    (0..7).each do |y|
      Piece.create(:type => 'Pawn', :color => 'white', :game_id => id, :x_position => y, :y_position => 6)
    end
    Piece.create(:type => 'Rook', :color => 'white', :game_id => id, :x_position => 0, :y_position => 7)
    Piece.create(:type => 'Rook', :color => 'white', :game_id => id, :x_position => 7, :y_position => 7)

    Piece.create(:type => 'Knight', :color => 'white', :game_id => id, :x_position => 1, :y_position => 7)
    Piece.create(:type => 'Knight', :color => 'white', :game_id => id, :x_position => 6, :y_position => 7)

    Piece.create(:type => 'Bishop', :color => 'white', :game_id => id, :x_position => 2, :y_position => 7)
    Piece.create(:type => 'Bishop', :color => 'white', :game_id => id, :x_position => 5, :y_position => 7)

    Piece.create(:type => 'King', :color => 'white', :game_id => id, :x_position => 4, :y_position => 7)
    Piece.create(:type => 'Queen', :color => 'white', :game_id => id, :x_position => 3, :y_position => 7)
  end

  # calling this in show.html.erb
  def piece_at(column_coordinate, row_coordinate)
    pieces.where(x_position: column_coordinate, y_position: row_coordinate).first
  end

  def check?(color)
    !!piece_causing_check(color)
  end

  def piece_causing_check(color)
    king = pieces.find_by(type: 'King', color: color)
    opposite_color = if color == "black"
      "white"
    else
      "black"
    end
    #find pieces still on board with opposite color (captured pieces are destroyed)
    opponents_pieces = pieces.where(color: opposite_color)

    opponents_pieces.find do |piece|
      piece.valid_move?(king.x_position, king.y_position)
    end
  end

  def can_be_captured?
    king = pieces.find_by(type: 'King')
    pieces_remaining = pieces.where(color: king.color)

    pieces_remaining.each do |piece|
      if piece.valid_move?(piece_causing_check(king.color).x_position, piece_causing_check(king.color).y_position)
       return true
      end
    end

    return false
  end

  def can_be_blocked?(color)
    king = pieces.find_by(type: 'King')
    pieces_remaining = pieces.where(color: king.color)

    if king.color == 'black'
      opposite_color = 'white'
    else
      opposite_color = 'black'
    end

    # finding range(s) between piece_causing_check and king being checked
    pieces_remaining.each do |piece|
      if king.y_position <= piece_causing_check(opposite_color).y_position
        (king.y_position..piece_causing_check(opposite_color).y_position).each do |y_coord|

          if king.x_position <= piece_causing_check(opposite_color).x_position
            (king.x_position..piece_causing_check(opposite_color).x_position).each do |x_coord|
              return true if piece.valid_move?(x_coord, y_coord)
            end

          else
            (piece_causing_check(opposite_color).x_position..king.x_position).each do |x_coord|
              return true if piece.valid_move?(x_coord, y_coord)
            end

          end #if statement
        end # y_coord loop

      else
        (piece_causing_check(opposite_color).y_position..king.y_position).each do |y_coord|
          if king.x_position <= piece_causing_check(opposite_color).x_position
            (king.x_position..piece_causing_check(opposite_color).x_position).each do |x_coord|
              return true if piece.valid_move?(x_coord, y_coord)
            end

          else
            (piece_causing_check(opposite_color).x_position..king.x_position).each do |x_coord|
              return true if piece.valid_move?(x_coord, y_coord)
            end

          end # if statement
        end  # y_coord

      end # big if statement

    end # END of pieces_remaining.each do

    return false
  end

  def checkmate?(color)
    king_in_check = pieces.find_by(type: 'King', color: color)

    # check if these conditions exist
    if check?(color)
      if can_be_blocked?(color)
        return false
      end
      if can_be_captured?
        return false
      end
      if king_in_check.can_escape?
        return false
      end
      return true #checkmate!
    else
      return false
    end

  end

end
