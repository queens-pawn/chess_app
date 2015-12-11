require 'test_helper'

class KnightTest < ActiveSupport::TestCase
  def setup
    @knight = Knight.create(x_position: 1, y_position: 1)
  end

  test "Knight valid move up" do
    assert_equal true, @knight.valid_move?(0, 3)
  end

  test "Knight invalid move up" do
    assert_equal false, @knight.valid_move?(0, 2)
  end

  test "Knight valid move down" do
    assert_equal true, @knight.valid_move?(0, 3)
  end

  test "Knight invalid move down" do
  	assert_equal false, @knight.valid_move?(0,5)
  end

  test "Knight valid move right" do
    assert_equal true, @knight.valid_move?(3, 2)
  end

  test "Knight invalid move right" do
  	assert_equal false, @knight.valid_move?(3,1)
  end

  test "Knight x position off board" do
    assert_equal false, @knight.valid_move?(-1, 0)
  end

  test "Knight y position off board" do
    assert_equal false, @knight.valid_move?(0, -1)
  end
end
