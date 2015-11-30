class PiecesController < ApplicationController

  private

  def piece_params
    params.require(:piece).permit(:type, :color, :game_id, :x_position, :y_position)
  end
end
