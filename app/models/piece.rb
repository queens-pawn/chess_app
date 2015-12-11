class Piece < ActiveRecord::Base
  belongs_to :game
  validate :validate_color?

  def self.types
    %w(King Queen Rook Bishop Knight Pawn)
  end

  def validate_color?
    errors.add(:color, 'Invalid color') unless color == 'white' || color == 'black'
  end
  
  def valid_move?(x, y)
    if x < 0 || x > 7
      return false
    elsif y < 0 || y > 7
      return false
    end
    return true
  end
end
