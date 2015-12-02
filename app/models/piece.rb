class Piece < ActiveRecord::Base
  belongs_to :game
  validate :validate_color?

  def self.types
    %w(King Queen Rook Bishop Knight Pawn)
  end

  def validate_color?
    errors.add(:color, 'Invalid color') unless color == 'white' || color == 'black'
  end
end
