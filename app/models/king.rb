class King < Piece

  def valid_move?(x, y)
    unless super(x, y)
      return false
    end
    (x_position - x).abs <= 1 && (y_position - y).abs <= 1 
  end

  def to_my_image_path
    # in assets/images
    "king_#{color}.svg"
  end

end
