require 'test_helper'

class PiecesControllerTest < ActionController::TestCase
  # test "should get show" do
  #   piece = FactoryGirl.create(:piece)
  #   get :show, :id => piece.id
  #   assert_response :success
  # end

  test "should get update" do
    piece = FactoryGirl.create(:piece)
    put :update, :id => piece.id, :piece => { :x_position => 1, :y_position => 2 }
    assert_equal 1, Piece.find(piece.id).x_position
    assert_redirected_to game_path(piece)
  end
end
