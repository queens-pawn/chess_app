require 'test_helper'

class KingTest < ActiveSupport::TestCase
  def test_valid_move?
    king = King.new(x_position: 4, y_position: 4)

    assert(
      king.valid_move?(5, 4)
    )
    assert(
      king.valid_move?(4, 5)
    )
    assert(
      king.valid_move?(3, 4)
    )
    assert(
      king.valid_move?(4, 3)
    )
    assert(
      king.valid_move?(5, 5)
    )
    assert(
      king.valid_move?(3, 5)
    )
    assert(
      king.valid_move?(3, 3)
    )
    assert(
      king.valid_move?(5, 3)
    )
  end

  def test_not_valid_move?
    king = King.new(x_position: 4, y_position: 0)

    assert_not (
      king.valid_move?(4, -1)
    )
    assert_not (
      king.valid_move?(3, 3)
    )
    assert_not (
      king.valid_move?(5, 3)
    )
    assert_not (
      king.valid_move?(4, 2)
    )
    assert_not (
      king.valid_move?(6, 0)
    )
    assert_not (
      king.valid_move?(2, 0)
    )
    assert_not (
      king.valid_move?(6, 0)
    )
  end

end
