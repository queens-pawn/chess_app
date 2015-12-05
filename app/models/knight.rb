class Knight < Piece

  def to_my_image_path
    # in assets/images
    if y_position == 6 || y_position == 7
    "knight_white.svg"
    else
    "knight_black.svg"
    end

  end

end
