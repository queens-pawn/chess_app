class Rook < Piece

  def to_my_image_path
    # in assets/images
    if y_position == 6 || y_position == 7
    "rook_white.svg"
    else
    "rook_black.svg"
    end

  end

end
