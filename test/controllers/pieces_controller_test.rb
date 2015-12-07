require 'test_helper'

class PiecesControllerTest < ActionController::TestCase
<<<<<<< HEAD
=======
  # test "should get show" do
  #   piece = FactoryGirl.create(:piece)
  #   get :show, :id => piece.id
  #   assert_response :success
  # end

>>>>>>> e7068d99febd159db0a25f47bbfd9e720d1122dc
  test "should get update" do
    piece = FactoryGirl.create(:piece)
    put :update, :id => piece.id, :piece => { :x_position => 1, :y_position => 2 }
    # assert_equal 1, Piece.find(piece.id).x_position
    assert_redirected_to game_path(piece)
  end
end
