class Game < ActiveRecord::Base
  after_create :populate_board!

  def populate_board!
    (0..7).each do |x|
      Piece.create {:type => 'Pawn', :color => 'white', :game_id => id, :x_position => x, :y_position => 1}
    end
    Piece.create {:type => 'Rook', :color => 'white', :game_id => id, :x_position => 0, :y_position => 0}
  end
end
