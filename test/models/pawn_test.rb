require 'test_helper'

class PawnTest < ActiveSupport::TestCase
  def setup
    @first_white_pawn = Pawn.create(color: 'white', x_position: 3, y_position: 6)
    @second_white_pawn = Pawn.create(color: 'white', x_position: 5, y_position: 5)
    @first_black_pawn = Pawn.create(color: 'black', x_position: 0, y_position: 1)
    @second_black_pawn = Pawn.create(color: 'black', x_position: 2, y_position: 2)
  end

  test "First move white 1 space foward" do
    assert_equal true, @first_white_pawn.valid_move?(3, 5)
  end

  test "White first move pawn 2 space foward" do
    assert_equal true, @first_white_pawn.valid_move?(3, 4)
  end

  test "Invalid too many steps foward(first move)" do
    assert_equal false, @first_white_pawn.valid_move?(3, 3)
    assert_equal false, @first_black_pawn.valid_move?(0, 5)
  end

  test "Invalid backward move" do
    assert_equal false, @first_white_pawn.valid_move?(3, 7)
    assert_equal false, @second_white_pawn.valid_move?(5, 6)
    assert_equal false, @first_black_pawn.valid_move?(0, 0)
    assert_equal false, @second_black_pawn.valid_move?(2, 1)
  end

  test "After white first move, 1 space foward" do
    assert_equal true, @second_white_pawn.valid_move?(5, 4)
  end

  test "Invalid move, moved too many steps foward" do
    assert_equal false, @second_white_pawn.valid_move?(5, 2)
    assert_equal false, @second_black_pawn.valid_move?(2, 4)
  end

  test "First move black 1 space foward" do
    assert_equal true, @first_black_pawn.valid_move?(0, 2)
  end

  test "First move black 2 space foward" do
    assert_equal true, @first_black_pawn.valid_move?(0, 3)
  end

  test "After black first move, 1 space foward" do
    assert_equal true, @second_black_pawn.valid_move?(2, 3)
  end
end
