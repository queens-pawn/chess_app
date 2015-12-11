class Knight < Piece
  #make sure doesnt include is_obstructed method when added to piece as can jump over pieces.
  def valid_move?(x, y)
    unless super(x, y)
      return false
    end
    if x_position - x == 0 || y_position - y == 0
      return false
    end
    (x_position - x).abs + (y_position - y).abs == 3
  end

  def to_my_image_path
    # in assets/images
    "knight_#{color}.svg"
  end
end
