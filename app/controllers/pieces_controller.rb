class PiecesController < ApplicationController

  def show
    @piece = Piece.find(params[:id])
    @piece.game.pieces
  end

  private

  def piece_params
    params.require(:piece).permit(:type, :color, :game_id, :x_position, :y_position)
  end
end
