require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  test "should get show" do
    game = Game.create(:name => "Test")
    get :show, :id => game.id
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

end
