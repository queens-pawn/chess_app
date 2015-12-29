require 'test_helper'

class GameTest < ActiveSupport::TestCase

  test "populate board" do
    game = FactoryGirl.create(:game)
    assert_equal 32, game.pieces.count
  end

  def setup
    @game = FactoryGirl.create(:game)
    @game.populate_board!
    @game.save
  end
  
  test "any pieces causing check false" do
    assert_equal false, @game.check?("white")
  end

  test "any pieces causing check true 1" do
    #bottom pawn to f4
    black_pawn1 = @game.pieces.find_by(type: "Pawn", x_position: 5, y_position: 1)
    black_pawn1.update_attributes(x_position: 5, y_position: 3)
    #top pawn to e6
    white_pawn1 = @game.pieces.find_by(type: "Pawn", x_position: 4, y_position: 6)
    white_pawn1.update_attributes(x_position: 4, y_position: 5)
    #bottom pawn to g4
    black_pawn2 = @game.pieces.find_by(type: "Pawn", x_position: 6, y_position: 1)
    black_pawn2.update_attributes(x_position: 6, y_position: 3)
    #top queen to h4
    white_queen = @game.pieces.find_by(type: "Queen", x_position: 3, y_position: 7)
    white_queen.update_attributes(x_position: 7, y_position: 3)
    assert_equal true, @game.check?("black")
  end

  test "any pieces causing check true 2" do
    Pawn.destroy_all(color: 'black', game: @game)
    @game.pieces.create(x_position: 2, y_position: 6, type: 'Bishop', color: 'white')
    assert_equal true, @game.check?("black")
  end
end
