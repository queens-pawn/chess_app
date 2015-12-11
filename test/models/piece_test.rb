require 'test_helper'

class PieceTest < ActiveSupport::TestCase
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
