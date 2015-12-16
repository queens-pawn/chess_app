class Pawn < Piece

  def valid_move?(x, y)
    unless super(x, y)
      return false
    end
    if color == 'white'
      if y_position == 6
        (x_position - x == 0 && y_position - y == 1) || (x_position - x == 0 && y_position - y == 2)
      else
        x_position - x == 0 && y_position - y == 1
      end
    else
      if y_position == 1
        (x - x_position == 0 && y - y_position == 1) || (x - x_position == 0 && y - y_position == 2)
      else
        x - x_position == 0 && y - y_position == 1
      end
    end
  end

  def to_my_image_path
    # in assets/images
    "pawn_#{color}.svg"
  end
end
