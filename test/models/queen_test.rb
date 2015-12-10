require 'test_helper'

class QueenTest < ActiveSupport::TestCase

  test "Queen valid move" do
    queen = Queen.create(x_position: 3, y_position: 7)
    assert_equal true, queen.valid_move?(0, 7)
    assert_equal true, queen.valid_move?(3, 2)
  end
end
