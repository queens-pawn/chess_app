class Pawn < Piece

  def valid_move?(x, y)
    unless super(x, y)
      return false
    end
    if occupied?(x, y)
      if color == 'white'
        (x_position - x).abs == 1 && y_position - y == 1
      else
        (x - x_position).abs == 1 && y - y_position == 1
      end
    elsif color == 'white'
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

  def occupied?(x, y)
    unless Piece.any?
      return false
    end
  end

  def to_my_image_path
    # in assets/images
    "pawn_#{color}.svg"
  end
end
