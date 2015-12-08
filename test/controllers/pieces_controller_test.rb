require 'test_helper'

class PiecesControllerTest < ActionController::TestCase
  test "should get update" do
    piece = FactoryGirl.create(:piece)
    put :update, :id => piece.id, :piece => { :x_position => 1, :y_position => 2 }
    piece.reload
    assert_equal 1, piece.x_position
    assert_equal 2, piece.y_position
    assert_response :found
    assert_redirected_to game_path(piece.game)
  end
end
