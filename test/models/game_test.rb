require 'test_helper'
require 'rr'

class GameTest < ActiveSupport::TestCase

  test "populate board" do
    game = FactoryGirl.create(:game)
    game.populate_board!
    assert_equal 32, game.pieces.count
  end

  def setup
    #sets up a game without polulating the board
    @game = FactoryGirl.create(:game)
  end

  test "any" do
    @game.populate_board!
    assert_equal false, @game.check?("white")
    assert_equal false, @game.check?("black")
  end

  test "no checkmate for black" do
    FactoryGirl.create(:piece, type: 'King', color: 'black', x_position: 2, y_position: 0, game: @game)
    FactoryGirl.create(:piece, type: 'Bishop', color: 'black', x_position: 4, y_position: 0, game: @game)
    FactoryGirl.create(:piece, type: 'Rook', color: 'black', x_position: 0, y_position: 3, game: @game)
    FactoryGirl.create(:piece, type: 'Pawn', color: 'black', x_position: 0, y_position: 1, game: @game)
    FactoryGirl.create(:piece, type: 'Pawn', color: 'black', x_position: 1, y_position: 1, game: @game)
    FactoryGirl.create(:piece, type: 'Pawn', color: 'black', x_position: 2, y_position: 1, game: @game)

    FactoryGirl.create(:piece, type: 'King', color: 'white', x_position: 6, y_position: 7, game: @game)
    target_piece = FactoryGirl.create(:piece, type: 'Bishop', color: 'white', x_position: 5, y_position: 3, game: @game)
    FactoryGirl.create(:piece, type: 'Rook', color: 'white', x_position: 5, y_position: 7, game: @game)
    FactoryGirl.create(:piece, type: 'Pawn', color: 'white', x_position: 5, y_position: 6, game: @game)
    FactoryGirl.create(:piece, type: 'Pawn', color: 'white', x_position: 6, y_position: 5, game: @game)
    FactoryGirl.create(:piece, type: 'Pawn', color: 'white', x_position: 7, y_position: 6, game: @game)

    stub(@game).piece_causing_check { target_piece }
    # these all pass !
    assert_equal 12,    @game.pieces.count
    assert_equal true,  @game.can_be_captured?
    assert_equal true,  @game.can_be_blocked?('black')
    assert_equal false, @game.checkmate?('black')
    assert_equal false, @game.checkmate?('white')
  end

  test "checkmate for black2" do
    King.create(color: 'black', x_position: 6, y_position: 0, game: @game)
    Queen.create(color: 'black', x_position: 6, y_position: 3, game: @game)
    Rook.create(color: 'black', x_position: 1, y_position: 5, game: @game)
    Pawn.create(color: 'black', x_position: 5, y_position: 1, game: @game)
    Pawn.create(color: 'black', x_position: 6, y_position: 1, game: @game)
    Pawn.create(color: 'black', x_position: 7, y_position: 1, game: @game)

    King.create(color: 'white', x_position: 6, y_position: 7, game: @game)
    target_piece = Queen.create(color: 'white', x_position: 4, y_position: 0, game: @game)
    Rook.create(color: 'white', x_position: 5, y_position: 7, game: @game)
    Pawn.create(color: 'white', x_position: 5, y_position: 6, game: @game)
    Pawn.create(color: 'white', x_position: 6, y_position: 6, game: @game)
    Pawn.create(color: 'white', x_position: 7, y_position: 6, game: @game)

    #stub(@game).piece_causing_check { target_piece }

    assert_equal false, @game.can_be_blocked?('black') # returning true for some reason
    # assert_equal false,  @game.can_escape?('black') #b king no moves
    # assert_equal false,  @game.can_be_captured?('black') #b can't capture

  end

  test "causing check" do
    @game.populate_board!

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

  #not passing (lm)
  test "any2" do
    @game.populate_board!
    Pawn.destroy_all(color: 'black', game: @game)
    @game.pieces.create(x_position: 2, y_position: 6, type: 'Bishop', color: 'white')
    assert_equal true, @game.check?('black')
  end

  test "blocking working" do
    King.create(color: 'black', x_position: 0, y_position: 7, game: @game)
    target = Rook.create(color: 'white', x_position: 0, y_position: 0, game: @game)
    Rook.create(color: 'black', x_position: 3, y_position: 3, game: @game)

    stub(@game).piece_causing_check {target}

    assert_equal true, @game.check?('black')
    assert_equal true, @game.can_be_blocked?('black')
  end

  test "king can escape" do
    testking = King.create(color: 'black', x_position: 0, y_position: 7, game: @game)
    Rook.create(color: 'white', x_position: 0, y_position: 0, game: @game)
    Rook.create(color: 'black', x_position: 3, y_position: 3, game: @game)

    assert_equal true, @game.check?('black')
    assert_equal true, testking.can_escape? # returning false
  end

  test "king no escape" do
    testking = King.create(color: 'black', x_position: 0, y_position: 0, game: @game)
    Rook.create(color: 'white', x_position: 0, y_position: 1, game: @game)
    Rook.create(color: 'white', x_position: 1, y_position: 1, game: @game)

    assert_equal true, @game.check?('black')
    assert_equal false, testking.can_escape?
  end

end
