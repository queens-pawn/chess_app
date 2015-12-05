class Bishop < Piece

  def to_my_image_path
    # in assets/images
    if y_position == 6 || y_position == 7
    "bishop_white.svg"
    else
    "bishop_black.svg"
    end

  end

end
