class PiecesController < ApplicationController

<<<<<<< HEAD
  # def show
  #   @game = current_piece.game
  #   @pieces = current_piece.game.pieces
  # end

  def update
    @game = current_piece.game

=======
  def show
    @game = current_piece.game
    @pieces = current_piece.game.pieces
  end

  def update
>>>>>>> e7068d99febd159db0a25f47bbfd9e720d1122dc
    x = params[:x_position]
    y = params[:y_position]
    current_piece.update_attributes(:x_position => x, :y_position => y)
    redirect_to game_path
  end

  private

  helper_method :current_piece
  def current_piece
    @current_piece ||= Piece.find(params[:id])
  end

  def piece_params
    params.require(:piece).permit(:x_position, :y_position)
  end
end
