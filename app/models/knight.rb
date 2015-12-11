class Knight < Piece

	def valid_move?(x_destination, y_destination)
		#check whether out of bounds
		return false if out_of_bounds?(x_destination, y_destination)
		#make sure the length of move is correct
		correct_length?(x_destination, y_destination)
	end

	#similar to pull request to be added app/models/piece.rb to be moved out once added, maybe renamed?
	def out_of_bounds?(x_destination, y_destination)
		if x_destination < 0 || x_destination > 7
			return true
		elsif y_destination < 0 || y_destination > 7
			return true
		end
	end

	#check to see if move is of correct length
	def correct_length?(x_destination, y_destination)
		(x_position - x_destination) + (y_position - y_destination) == 3
	end

  def to_my_image_path
    # in assets/images
    "knight_#{color}.svg"
  end
end
