class Game < ActiveRecord::Base
  after_create :populate_board!

  def populate_board!
    (0..7).each do |y|
      Piece.create {:type => 'Pawn', :color => 'white', :game_id => id, :x_position => 1, :y_position => y}
    end
    Piece.create {:type => 'Rook', :color => 'white', :game_id => id, :x_position => 0, :y_position => 0}
    Piece.create {:type => 'Rook', :color => 'white', :game_id => id, :x_position => 0, :y_position => 7}

    Piece.create {:type => 'Knight', :color => 'white', :game_id => id, :x_position => 0, :y_position => 1}
    Piece.create {:type => 'Knight', :color => 'white', :game_id => id, :x_position => 0, :y_position => 6}

    Piece.create {:type => 'Bishop', :color => 'white', :game_id => id, :x_position => 0, :y_position => 2}
    Piece.create {:type => 'Bishop', :color => 'white', :game_id => id, :x_position => 0, :y_position => 5}

    Piece.create {:type => 'King', :color => 'white', :game_id => id, :x_position => 0, :y_position => 4}
    Piece.create {:type => 'Queen', :color => 'white', :game_id => id, :x_position => 0, :y_position => 3}

    (0..7).each do |y|
      Piece.create {:type => 'Pawn', :color => 'black', :game_id => id, :x_position => 6, :y_position => y}
    end
    Piece.create {:type => 'Rook', :color => 'black', :game_id => id, :x_position => 7, :y_position => 0}
    Piece.create {:type => 'Rook', :color => 'black', :game_id => id, :x_position => 7, :y_position => 7}

    Piece.create {:type => 'Knight', :color => 'black', :game_id => id, :x_position => 7, :y_position => 1}
    Piece.create {:type => 'Knight', :color => 'black', :game_id => id, :x_position => 7, :y_position => 6}

    Piece.create {:type => 'Bishop', :color => 'black', :game_id => id, :x_position => 7, :y_position => 2}
    Piece.create {:type => 'Bishop', :color => 'black', :game_id => id, :x_position => 7, :y_position => 5}

    Piece.create {:type => 'King', :color => 'black', :game_id => id, :x_position => 7, :y_position => 4}
    Piece.create {:type => 'Queen', :color => 'black', :game_id => id, :x_position => 7, :y_position => 3}
  end
end
