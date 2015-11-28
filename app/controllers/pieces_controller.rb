class PiecesController < ApplicationController

  def create
    @game = Game.find(params[:id])
    @game.pieces.create(piece_params)
  end

  private

  def piece_params
    params.require(:piece).permit(:type, :color, :game_id, :x_position, :y_position)
  end
end
