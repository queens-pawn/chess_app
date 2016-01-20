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

  def can_escape?
    king_x = x_position
    king_y = y_position

    ((x_position - 1)..(x_position + 1)).each do |x_coord|
      ((y_position - 1)..(y_position + 1)).each do |y_coord|
        if valid_move?(x_coord, y_coord)
          update_attributes(x_position: x_coord, y_position: y_coord)
          return true if !game.check?(color) #returns true if any move enables 'escape'v
        end

        update_attributes(x_position: king_x, y_position: king_y)
      end
    end
    return false
  end

end
