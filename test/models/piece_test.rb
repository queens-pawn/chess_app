require 'test_helper'

class PieceTest < ActiveSupport::TestCase

  def setup
    @piece = FactoryGirl.create(:piece)
  end

	test "is_vertical_true" do 
    assert_equal true, @piece.is_vertical?(1, 2)
  end

  test "is_vertical_false" do 
    assert_equal false, @piece.is_vertical?(3, 2)
  end

  test "is_horizontal_true" do 
    assert_equal true, @piece.is_horizontal?(3, 1)
  end

  test "is_horizontal_false" do 
    assert_equal false, @piece.is_horizontal?(3, 2)
  end

  test "is_diagonal_true" do 
    assert_equal true, @piece.is_diagonal?(3, 3)
  end

  test "is_diagonal_false" do 
    assert_equal false, @piece.is_diagonal?(3, 2)
  end

  test "vertical_obstruction_true?" do
  	piece = FactoryGirl.create(:piece, :x_position => 3, :y_position => 4)
  	pawn = Piece.create(:type => 'Pawn', :color => 'white', :game => piece.game, :x_position => 3, :y_position => 5)
    assert_equal true, piece.vertical_obstruction?(3, 6)
  end

  test "vertical_obstruction_false?" do
  	piece = FactoryGirl.create(:piece, :x_position => 6, :y_position => 2)
  	pawn = Piece.create(:type => 'Pawn', :color => 'white', :game => piece.game, :x_position => 6, :y_position => 6)
  	assert_equal false, piece.vertical_obstruction?(6, 4)
  end

  test "horizontal_obstruction_true?" do
  	piece = FactoryGirl.create(:piece, :x_position => 3, :y_position => 4)
  	pawn = Piece.create(:type => 'Pawn', :color => 'white', :game => piece.game, :x_position => 5, :y_position => 4)
  	assert_equal true, piece.horizontal_obstruction?(7, 4)
  end

  test "horizontal_obstruction_false?" do
  	piece = FactoryGirl.create(:piece, :x_position => 3, :y_position => 4)
  	pawn = Piece.create(:type => 'Pawn', :color => 'white', :game => piece.game, :x_position => 7, :y_position => 4)
  	assert_equal false, piece.horizontal_obstruction?(5, 4)
  end

  test "diagonal_obstruction_true?" do
  	piece = FactoryGirl.create(:piece, :x_position => 2, :y_position => 2)
  	pawn = Piece.create(:type => 'Pawn', :color => 'white', :game => piece.game, :x_position => 4, :y_position => 4)
  	assert_equal true, piece.diagonal_obstruction?(5, 5)
  end

  test "diagonal_obstruction_false?" do
  	piece = FactoryGirl.create(:piece, :x_position => 4, :y_position => 1)
  	pawn = Piece.create(:type => 'Pawn', :color => 'white', :game_id => 1, :x_position => 8, :y_position => 5)
  	assert_equal false, piece.diagonal_obstruction?(6, 3)
  end

  test "is_obstructed_horizontal?" do
  	piece = FactoryGirl.create(:piece, :x_position => 4, :y_position => 4)
  	pawn = Piece.create(:type => 'Pawn', :color => 'white', :game => piece.game, :x_position => 5, :y_position => 4)
  	assert_equal true, piece.is_obstructed?(8, 4)
  end

  test "is_obstructed_vertical?" do
  	piece = FactoryGirl.create(:piece, :x_position => 5, :y_position => 4)
  	pawn = Pawn.create(:color => 'white', :game => piece.game, :x_position => 5, :y_position => 7)
  	assert_equal true, piece.is_obstructed?(5, 8)
  end

  test "is_obstructed_diagonal?" do
  	piece = FactoryGirl.create(:piece, :x_position => 2, :y_position => 4)
  	pawn = Piece.create(:type => 'Pawn', :color => 'white', :game => piece.game, :x_position => 5, :y_position => 7)
  	assert_equal true, piece.is_obstructed?(6, 8)
  end

  test "is_obstructed_invalid?" do
  	piece = FactoryGirl.create(:piece, :x_position => 4, :y_position => 4)
  	assert_raise(RuntimeError) { piece.is_obstructed?(2,5) }
  end
end