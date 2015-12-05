class Pawn < Piece

  def to_my_image_path
    # in assets/images
    if y_position == 6 || y_position == 7
    "pawn_white.svg"
    else
    "pawn_black.svg"
    end

  end



end
