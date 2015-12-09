class PiecesController < ApplicationController

  def update
    @game = current_piece.game
    current_piece.update_attributes(piece_params)
    redirect_to game_path(@game)
  end

  private

  helper_method :current_piece
  def current_piece
    @current_piece ||= Piece.find(params[:id])
  end

  def piece_params
    params.require(:piece).permit(:type, :x_position, :y_position)
  end
end
