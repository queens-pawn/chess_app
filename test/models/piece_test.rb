require 'test_helper'

class PieceTest < ActiveSupport::TestCase
	test "is_vertical_true" do 
    piece = Piece.create(:type => 'King', :color => 'white', :game_id => 1, :x_position => 3, :y_position => 4)
    expected = true
    actual = piece.is_vertical?(3, 7)
    assert_equal expected, actual
  end

  test "is_vertical_false" do 
    piece = Piece.create(:type => 'King', :color => 'white', :game_id => 1, :x_position => 3, :y_position => 4)
    expected = false
    actual = piece.is_vertical?(5, 7)
    assert_equal expected, actual
  end

  test "is_horizontal_true" do 
    piece = Piece.create(:type => 'King', :color => 'white', :game_id => 1, :x_position => 3, :y_position => 4)
    expected = true
    actual = piece.is_horizontal?(7, 4)
    assert_equal expected, actual
  end

  test "is_horizontal_false" do 
    piece = Piece.create(:type => 'King', :color => 'white', :game_id => 1, :x_position => 3, :y_position => 4)
    expected = false
    actual = piece.is_horizontal?(7, 5)
    assert_equal expected, actual
  end

  test "is_diagonal_true" do 
    piece = Piece.create(:type => 'King', :color => 'white', :game_id => 1, :x_position => 3, :y_position => 4)
    expected = true
    actual = piece.is_diagonal?(6, 7)
    assert_equal expected, actual
  end

  test "is_diagonal_false" do 
    piece = Piece.create(:type => 'King', :color => 'white', :game_id => 1, :x_position => 3, :y_position => 4)
    expected = false
    actual = piece.is_diagonal?(4, 6)
    assert_equal expected, actual
  end

  test "vertical_obstruction_true?" do
  	piece = Piece.create(:type => 'King', :color => 'white', :game_id => 1, :x_position => 3, :y_position => 4)
  	pawn = Piece.create(:type => 'Pawn', :color => 'white', :game_id => 1, :x_position => 3, :y_position => 5)
  	expected = true
    actual = piece.vertical_obstruction?(3, 6)
    assert_equal expected, actual
  end

  test "vertical_obstruction_false?" do
  	piece = Piece.create(:type => 'King', :color => 'white', :game_id => 1, :x_position => 6, :y_position => 2)
  	pawn = Piece.create(:type => 'Pawn', :color => 'white', :game_id => 1, :x_position => 6, :y_position => 6)
  	expected = false
    actual = piece.vertical_obstruction?(6, 4)
    assert_equal expected, actual
  end

  test "horizontal_obstruction_true?" do
  	piece = Piece.create(:type => 'King', :color => 'white', :game_id => 1, :x_position => 3, :y_position => 4)
  	pawn = Piece.create(:type => 'Pawn', :color => 'white', :game_id => 1, :x_position => 5, :y_position => 4)
  	expected = true
    actual = piece.horizontal_obstruction?(7, 4)
    assert_equal expected, actual
  end

  test "horizontal_obstruction_false?" do
  	piece = Piece.create(:type => 'King', :color => 'white', :game_id => 1, :x_position => 3, :y_position => 4)
  	pawn = Piece.create(:type => 'Pawn', :color => 'white', :game_id => 1, :x_position => 7, :y_position => 4)
  	expected = false
    actual = piece.horizontal_obstruction?(5, 4)
    assert_equal expected, actual
  end

  test "diagonal_obstruction_true?" do
  	piece = Piece.create(:type => 'King', :color => 'white', :game_id => 1, :x_position => 2, :y_position => 2)
  	pawn = Piece.create(:type => 'Pawn', :color => 'white', :game_id => 1, :x_position => 4, :y_position => 4)
  	expected = true
    actual = piece.diagonal_obstruction?(5, 5)
    assert_equal expected, actual
  end

  test "diagonal_obstruction_false?" do
  	piece = Piece.create(:type => 'King', :color => 'white', :game_id => 1, :x_position => 4, :y_position => 1)
  	pawn = Piece.create(:type => 'Pawn', :color => 'white', :game_id => 1, :x_position => 8, :y_position => 5)
  	expected = false
    actual = piece.diagonal_obstruction?(6, 3)
    assert_equal expected, actual
  end

  test "is_obstructed_horizontal?" do
  	piece = Piece.create(:type => 'King', :color => 'white', :game_id => 1, :x_position => 4, :y_position => 4)
  	pawn = Piece.create(:type => 'Pawn', :color => 'white', :game_id => 1, :x_position => 5, :y_position => 4)
  	expected = true
  	actual = piece.is_obstructed?(8, 4)
  	assert_equal expected, actual
  end

  test "is_obstructed_vertical?" do
  	piece = Piece.create(:type => 'King', :color => 'white', :game_id => 1, :x_position => 5, :y_position => 4)
  	pawn = Piece.create(:type => 'Pawn', :color => 'white', :game_id => 1, :x_position => 5, :y_position => 7)
  	expected = true
  	actual = piece.is_obstructed?(5, 8)
  	assert_equal expected, actual
  end

  test "is_obstructed_diagonal?" do
  	piece = Piece.create(:type => 'King', :color => 'white', :game_id => 1, :x_position => 2, :y_position => 4)
  	pawn = Piece.create(:type => 'Pawn', :color => 'white', :game_id => 1, :x_position => 5, :y_position => 7)
  	expected = true
  	actual = piece.is_obstructed?(6, 8)
  	assert_equal expected, actual
  end

  test "is_obstructed_invalid?" do
  	piece = Piece.create(:type => 'King', :color => 'white', :game_id => 1, :x_position => 4, :y_position => 4)
  	assert_raise(RuntimeError) { piece.is_obstructed?(2,5) }
  end
end