class Game < ActiveRecord::Base
  has_many :pieces
  after_create :populate_board!

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
    king = pieces.find_by(type: 'King', color: color)
    if color == "black" 
      opposite_color = "white"
    else 
      opposite_color = "black"
    end
    #find pieces still on board with opposite color (captured pieces are destroyed)
    opponents_pieces = pieces.where(color: opposite_color)
    #for each of opponents pieces check whether can move to position of king
    check = false
    opponents_pieces.each do |piece|
      if piece.valid_move?(king.x_position, king.y_position)
        @piece_causing_check = piece #to use when checking for checkmate
        check = true      
        break         
      end
    end
    check
  end
end
