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
  end
end
