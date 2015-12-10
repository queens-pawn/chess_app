class Piece < ActiveRecord::Base
  belongs_to :game
  validate :validate_color?

  def self.types
    %w(King Queen Rook Bishop Knight Pawn)
  end

  def validate_color?
    errors.add(:color, 'Invalid color') unless color == 'white' || color == 'black'
  end

  def move_to!(new_x, new_y)
    move_to_position = [x_position: new_x, y_position: new_y]

    # if the move_to_position is NOT empty...
    if !move_to_position.empty?
      if current_piece.color == other_piece.color
        return an error message -- not valid move
      else
        other_piece => goes offboard
      end
      current_piece.update(x_position: new_x, y_position: new_y)
    else
      current_piece.update(x_position: new_x, y_position: new_y)
    end

  end

end
