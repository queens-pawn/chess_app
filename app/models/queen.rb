class Queen < Piece

  def valid_move?(x_position, y_positison)
    x, y = x_position, y_position
    x_position == x || y_position == y || (x_position - x).abs == (y_position - y).abs
  end

  def to_my_image_path
    # in assets/images
    "queen_#{color}.svg"
  end

end
