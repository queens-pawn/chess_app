require 'test_helper'

class GameTest < ActiveSupport::TestCase

  test "populate board" do
    game = FactoryGirl.create(:game)
    game.populate_board!
    assert_equal 32, game.pieces.count
  end

  def setup
    @game = FactoryGirl.create(:game)
    @game.populate_board!
    @game.save
  end

  test "any opposite pieces causing check false" do
    assert_equal false, @game.check?("white")
    assert_equal false, @game.check?("black")
  end

  test "any pieces causing check true 1" do

    b_pawn1 = @game.pieces.find_by(type: "Pawn", x_position: 5, y_position: 1)
    b_pawn1.update_attributes(x_position: 5, y_position: 3)

    w_pawn1 = @game.pieces.find_by(type: "Pawn", x_position: 4, y_position: 6)
    w_pawn1.update_attributes(x_position: 4, y_position: 5)

    b_pawn2 = @game.pieces.find_by(type: "Pawn", x_position: 6, y_position: 1)
    b_pawn2.update_attributes(x_position: 6, y_position: 3)

    white_queen = @game.pieces.find_by(type: "Queen", x_position: 3, y_position: 7)
    white_queen.update_attributes(x_position: 7, y_position: 3)

    assert_equal true, @game.check?("black")
  end

  test "any pieces causing check true 2" do
    Pawn.destroy_all(color: 'black', game: @game)
    @game.pieces.create(type: "Bishop", color: "white", x_position: 6, y_position: 2)
    assert_equal true, @game.check?("black")
  end

  test "Checkmate is false" do
    game = FactoryGirl.create(:game)

    King.create(  color: 'black', x_position: 2, y_position: 0, game: game)
    Bishop.create(color: 'black', x_position: 4, y_position: 0, game: game)
    Rook.create(  color: 'black', x_position: 0, y_position: 3, game: game)
    Pawn.create(  color: 'black', x_position: 0, y_position: 1, game: game)
    Pawn.create(  color: 'black', x_position: 1, y_position: 1, game: game)
    Pawn.create(  color: 'black', x_position: 2, y_position: 1, game: game)

    King.create(  color: 'white', x_position: 6, y_position: 7, game: game)
    Bishop.create(color: 'white', x_position: 5, y_position: 3, game: game)
    Rook.create(  color: 'white', x_position: 5, y_position: 7, game: game)
    Pawn.create(  color: 'white', x_position: 5, y_position: 6, game: game)
    Pawn.create(  color: 'white', x_position: 6, y_position: 5, game: game)
    Pawn.create(  color: 'white', x_position: 7, y_position: 6, game: game)

    assert_equal 12,    game.pieces.count
    assert_equal true,  game.check?('black')
    assert_equal false, game.check?('white')

    assert_equal false, game.checkmate?('black')
    # assert_equal true,  game.can_escape?('black') #b king B8
    # assert_equal true,  game.can_be_blocked?('black') #b bishop D7
    # assert_equal true,  game.can_be_captured?('black') #b rook F5
  end

  test "Checkmate is true" do
    game = FactoryGirl.create(:game)

    King.create(  color: 'black', x_position: 6, y_position: 0, game: game)
    Queen.create( color: 'black', x_position: 6, y_position: 3, game: game)
    Rook.create(  color: 'black', x_position: 1, y_position: 5, game: game)
    Pawn.create(  color: 'black', x_position: 5, y_position: 1, game: game)
    Pawn.create(  color: 'black', x_position: 6, y_position: 1, game: game)
    Pawn.create(  color: 'black', x_position: 7, y_position: 1, game: game)

    King.create(  color: 'white', x_position: 6, y_position: 7, game: game)
    Queen.create( color: 'white', x_position: 4, y_position: 0, game: game)
    Rook.create(  color: 'white', x_position: 5, y_position: 7, game: game)
    Pawn.create(  color: 'white', x_position: 5, y_position: 6, game: game)
    Pawn.create(  color: 'white', x_position: 6, y_position: 6, game: game)
    Pawn.create(  color: 'white', x_position: 7, y_position: 6, game: game)

    assert_equal 12,    game.pieces.count
    assert_equal true,  game.check?('black')
    assert_equal false, game.check?('white')

    assert_equal true,  game.checkmate?('black')
    # assert_equal false,  game.can_escape?('black') #b king no moves
    # assert_equal false,  game.can_be_blocked?('black') #b  no pieces can block
    # assert_equal false,  game.can_be_captured?('black') #b can't capture
  end

  test "blocking working" do
    game = FactoryGirl.create(:game)

    King.create(color: 'black', x_position: 0, y_position: 7, game: game)
    Rook.create(color: 'white', x_position: 0, y_position: 0, game: game)
    Rook.create(color: 'black', x_position: 3, y_position: 3, game: game)

    assert_equal true, game.check?('black')
    assert_equal true, game.can_be_blocked?
  end

end
