class Bishop < Piece

  def valid_move?(x, y)
    unless super(x, y)
      return false
    end
    (x_position - x).abs == (y_position - y).abs
  end

  def to_my_image_path
    # in assets/images
    "bishop_#{color}.svg"
  end
end
