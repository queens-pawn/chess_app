class Knight < Piece
  #make sure doesnt include is_obstructed method when added to piece as can jump over pieces.
	def valid_move?(x, y)
		#check whether out of bounds
		unless super(x, y)
			return false
		end
		#make sure the length of move is correct
		(x_position - x).abs + (y_position - y).abs == 3
	end

	#similar to pull request to be added app/models/piece.rb to be moved out once added, maybe renamed?

	#check to see if move is of correct length

  def to_my_image_path
    # in assets/images
    "knight_#{color}.svg"
  end
end
