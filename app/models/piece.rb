class Piece < ActiveRecord::Base
  belongs_to :game
  validate :validate_color?

  def self.types
    %w(King Queen Rook Bishop Knight Pawn)
  end

  def validate_color?
    errors.add(:color, 'Invalid color') unless color == 'white' || color == 'black'
  end

  def move_to!(x_position: nil, y_position: nil)
    another_piece = self.game.piece_at(x_position, y_position)

    if another_piece #exists...
      if another_piece.color != self.color #check if same color
        another_piece.destroy
        successful_move!(x_position, y_position)
      end
    else
      successful_move!(x_position, y_position)
    end

  end

  private

  def successful_move!(x_position: nil, y_position: nil)
    self.update(x_position: x_position, y_position: y_position)
    :success
  end

end
