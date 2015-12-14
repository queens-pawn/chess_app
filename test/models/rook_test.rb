require 'test_helper'

class RookTest < ActiveSupport::TestCase
  def test_valid_vertical_move?
    rook = Rook.new(x_position: 0, y_position: 0)
    assert(
      rook.valid_move?(0, 7)
    )
    assert(
      rook.valid_move?(0, 2)
    )
  end

  def test_invalid_vertical_move?
    rook = Rook.new(x_position: 7, y_position: 7)
    assert_not (
      rook.valid_move?(6, 6)
    )
    assert_not (
      rook.valid_move?(5, 6)
    )
  end

  def test_valid_horizontal_move?
    rook = Rook.new(x_position: 7, y_position: 0)
    assert(
      rook.valid_move?(0, 0)
    )
    assert(
      rook.valid_move?(3, 0)
    )
  end

  def test_invalid_horizontal_move?
    rook = Rook.new(x_position: 0, y_position: 7)
    assert_not (
      rook.valid_move?(7, 6)
    )
    assert_not (
      rook.valid_move?(1, 6)
    )
  end

  def test_rook_off_the_board?
    rook = Rook.new(x_position: 7, y_position: 0)
    assert_not (
      rook.valid_move?(8, 0)
    )
    assert_not (
      rook.valid_move?(7, 8)
    )
    assert_not (
      rook.valid_move?(-1, 0)
    )
    assert_not (
      rook.valid_move?(7, -1)
    )
  end

end
