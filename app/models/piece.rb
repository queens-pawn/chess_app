class Piece < ActiveRecord::Base
  belongs_to :game

  def self.types
    %w(King Queen Rook Bishop Knight Pawn)
  end

  def self.colors
    %w(white black)
  end
end
