class Pawn < Piece

  def to_my_image_path
    # in assets/images
    "pawn_#{color}.svg"
  end
end
