require 'test_helper'

class PieceTest < ActiveSupport::TestCase

  def setup
    @piece = FactoryGirl.create(:piece)
  end

  # CAPTURE LOGIC TESTS
  test '#move_to! with valid move and no piece exists' do
    piece = FactoryGirl.create(:piece)

    piece.move_to!(x_position: 0, y_position: 3)

    assert piece.x_position == 0, "expected x position to be 0"
    assert piece.y_position == 3, "expected y position to be 3"
  end

  test 'move_to! with valid move and opposite color piece exists' do
    game = FactoryGirl.create(:game)

    my_rook = game.pieces.create(x_position: 0, y_position: 3, type: 'Rook', color: 'white')
    other_rook = game.pieces.create(x_position: 7, y_position: 3, type: 'Rook', color: 'black')

    my_rook.move_to!(x_position: other_rook.x_position, y_position: other_rook.y_position)

    assert Piece.find_by(id: other_rook.id).nil?, "Did not remove other rook from board"
    assert my_rook.x_position == 7, "expected x position to be 7"
    assert my_rook.y_position == 3, "expected y position to be 3"
  end

  test '#move_to! with valid move and same color piece exists there' do
    game = FactoryGirl.create(:game)

    my_rook = game.pieces.create(x_position: 0, y_position: 3, type: 'Rook', color: 'white')
    other_rook = game.pieces.create(x_position: 7, y_position: 3, type: 'Rook', color: 'white')

    my_rook.move_to!(x_position: other_rook.x_position, y_position: other_rook.y_position)

    assert Piece.find_by(id: other_rook.id), "Removed same colored piece"
    assert my_rook.x_position == 0, "expected x position to be 0"
    assert my_rook.y_position == 3, "expected y position to be 3"
  end

  # VALID MOVE TESTS

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

  test 'piece valid move' do
    piece = FactoryGirl.create(:piece)
    assert_equal true, piece.valid_move?(1, 2)
  end

  test 'piece x off board' do
    piece = FactoryGirl.create(:piece)
    assert_equal false, piece.valid_move?(-1, 7)
  end

  test 'piece y off board' do
    piece = FactoryGirl.create(:piece)
    assert_equal false, piece.valid_move?(5, -3)
  end

  test 'both piece off board' do
    piece = FactoryGirl.create(:piece)
    assert_equal false, piece.valid_move?(-3, -4)
  end

end

