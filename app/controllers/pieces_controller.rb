class PiecesController < ApplicationController

  def show
    current_piece.game.pieces
  end

  def update
    x = params[:x_position]
    y = params[:y_position]
    current_piece.update_attributes(x, y)
    redirect_to game_path
  end

  private

  helper_method :current_piece
  def current_piece
    @current_piece ||= Piece.find(params[:id])
  end

  def piece_params
    params.require(:piece).permit(:type, :color, :game_id, :x_position, :y_position)
  end
end
