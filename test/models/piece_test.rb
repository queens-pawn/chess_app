require 'test_helper'

class PieceTest < ActiveSupport::TestCase

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
  def setup
    @piece = FactoryGirl.create(:piece)
  end

  test 'piece valid move' do
    assert_equal true, @piece.valid_move?(1, 2)
  end

  test 'piece x off board' do
    assert_equal false, @piece.valid_move?(-1, 7)
  end

  test 'piece y off board' do
    assert_equal false, @piece.valid_move?(5, -3)
  end

  test 'both piece off board' do
    assert_equal false, @piece.valid_move?(-3, -4)
  end

end
