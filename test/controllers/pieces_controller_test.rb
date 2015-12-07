require 'test_helper'

class PiecesControllerTest < ActionController::TestCase
  test "should get update" do
    piece = FactoryGirl.create(:piece)
    put :update, :id => piece.id, :piece => { :x_position => 1, :y_position => 2 }
    # assert_equal 2, Piece.find(piece.id).y_position
    assert_response :found
    assert_redirected_to game_path(piece)
  end
end
