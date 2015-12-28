class Pawn < Piece

  def valid_move?(x, y)
    unless super(x, y)
      return false
    end
    x_distance = x_position - x
    y_distance = y_position - y
    if promote?(y)
      if true
        promotion(x, y, type)
      else
        return false
      end
    elsif occupied?(x, y)
      if color == 'white'
        x_distance.abs == 1 && y_distance == 1
      else
        x_distance.abs == 1 && -y_distance == 1
      end
    elsif color == 'white'
      if has_moved
        x_distance == 0 && y_distance == 1
      else
        (x_distance == 0 && y_distance == 1) || (x_distance == 0 && y_distance == 2)
      end
    else
      if has_moved
        x_distance == 0 && -y_distance == 1
      else
        (x_distance == 0 && -y_distance == 1) || (x_distance == 0 && -y_distance == 2)
      end
    end
  end

  def occupied?(x, y)
    unless game.piece_at(x, y)
      return false
    end
    move_to!(x_position: x, y_position: y)
  end

  def promote?(y)
    y == 0 && color == 'white' || y == 7 && color == 'black'
  end

  def promotion(x, y, type)
    update_attributes(
      x_position: nil,
      y_position: nil
    )

    game.pieces.create(
      x_position: x,
      y_position: y,
      type: type,
      color: color
    )
  end

  def to_my_image_path
    # in assets/images
    "pawn_#{color}.svg"
  end
end
