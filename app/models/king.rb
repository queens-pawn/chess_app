class King < Piece

  def to_my_image_path
    # in assets/images
    if y_position == 6 || y_position == 7
    "king_white.svg"
    else
    "king_black.svg"
    end

  end

end
