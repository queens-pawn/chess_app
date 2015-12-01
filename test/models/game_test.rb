require 'test_helper'

class GameTest < ActiveSupport::TestCase

  test "populate board" do
    g = FactoryGirl.create(:game)
    assert_equal 32, g.pieces.count
  end
end
