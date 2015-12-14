require 'test_helper'

class GameTest < ActiveSupport::TestCase

  def setup
    @game = FactoryGirl.create(:game)
  end

  test "populate board" do
    assert_equal 32, @game.pieces.count
  end

  test "find white rooks" do
    assert_instance_of Rook, @game.piece_at(0, 0), 'Rook'
    assert_instance_of Rook, @game.piece_at(7, 0), 'Rook'
  end

  test "Rook not found" do
    refute_instance_of Rook, @game.piece_at(1, 0), 'Rook'
    refute_instance_of Rook, @game.piece_at(3, 3), 'Rook'
  end

  test "Knight found" do
    assert_instance_of Knight, @game.piece_at(1, 0), 'Knight'
  end

  test "Knight not found" do
    refute_instance_of Knight, @game.piece_at(5, 0), 'Knight'
  end

  test 'Bishop found' do
    assert_instance_of Bishop, @game.piece_at(2, 0), 'Bishop'
  end

  test 'Bishop not found' do
    refute_instance_of Bishop, @game.piece_at(3, 0), 'Bishop'
  end

  test 'Queen found' do
    assert_instance_of Queen, @game.piece_at(3, 0), 'Queen'
  end

  test 'Queen not found' do
    refute_instance_of Queen, @game.piece_at(4, 0), 'Queen'
  end

  test 'King found' do
    assert_instance_of King, @game.piece_at(4, 0), 'Queen'
  end

  test 'King not found' do
    refute_instance_of King, @game.piece_at(3, 0), 'King'
  end

  test 'Pawn found' do
    assert_instance_of Pawn, @game.piece_at(1, 1), 'Pawn'
  end

  test 'Pawn not found' do
    refute_instance_of Pawn, @game.piece_at(2, 2), 'Pawn'
  end
end
