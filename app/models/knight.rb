class Knight < Piece
  #make sure doesnt include is_obstructed method when added to piece as can jump over pieces.
	def valid_move?(x, y)
		#check whether out of bounds
		unless super(x, y)
			return false
		end
		if x_position - x == 0 || y_position - y == 0
      return false
    end
		(x_position - x).abs + (y_position - y).abs == 3
	end

	#similar to pull request to be added app/models/piece.rb to be moved out once added, maybe renamed?

	#check to see if move is of correct length

  def to_my_image_path
    # in assets/images
    "knight_#{color}.svg"
  end
end
