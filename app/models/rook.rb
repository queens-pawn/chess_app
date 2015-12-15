class Rook < Piece

  def valid_move?(x, y)
    unless super(x, y)
      return false
    end
    x_position == x && (y_position - y).abs || (x_position - x).abs && y_position == y  
  end

  def to_my_image_path
    # in assets/images
    "rook_#{color}.svg"
  end

end
