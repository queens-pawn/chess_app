class Queen < Piece

  def to_my_image_path
    # in assets/images
    if y_position == 6 || y_position == 7
    "queen_white.svg"
    else
    "queen_black.svg"
    end

  end

end
