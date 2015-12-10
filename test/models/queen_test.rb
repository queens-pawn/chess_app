require 'test_helper'

class QueenTest < ActiveSupport::TestCase
  def setup
    @queen = Queen.create(x_position: 0, y_position: 0)
  end

  test "Queen valid vertical move" do
    assert_equal true, @queen.valid_move?(0, 5)
  end

  test "Queen valid horizontal move" do
    assert_equal true, @queen.valid_move?(5, 0)
  end

  test "Queen valid diagonal move" do
    assert_equal true, @queen.valid_move?(3, 3)
  end

  test "Queen x position off board" do
    assert_equal false, @queen.valid_move?(-1, 0)
  end

  test "Queen y position off board" do
    assert_equal false, @queen.valid_move?(0, -3)
  end

  test "Queen diagonal invalid move" do
    assert_equal false, @queen.valid_move?(2, 1)
  end
end
