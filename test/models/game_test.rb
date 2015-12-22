require 'test_helper'

class GameTest < ActiveSupport::TestCase

  test "populate board" do
    game = FactoryGirl.create(:game)
    assert_equal 32, game.pieces.count
  end

  def setup
    @game = FactoryGirl.create(:game)
    @game.populate_board!
  end

  test "any pieces causing check false" do
    assert_equal false, @game.check?("black")
  end
end
