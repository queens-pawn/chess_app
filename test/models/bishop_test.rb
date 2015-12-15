require 'test_helper'

class BishopTest < ActiveSupport::TestCase
	def setup
		@bishop = Bishop.create(x_position: 2, y_position: 2)
	end

	test "Bishop valid diagonal move" do
		assert_equal true, @bishop.valid_move?(3, 3)
	end

	test "Bishop valid diagonal backwards" do
		assert_equal true, @bishop.valid_move?(1, 1)
	end

	test "Bishop diagonal invalid move" do
		assert_equal false, @bishop.valid_move?(3, 2)
	end

	test "Bishop position off board" do
		assert_equal false, @bishop.valid_move?(-1, -1)
	end
end