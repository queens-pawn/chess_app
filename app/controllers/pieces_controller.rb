class PiecesController < ApplicationController

  def update
    @game = current_piece.game
    if current_piece.valid_move?(piece_params[:x_position].to_i, piece_params[:y_position].to_i)
      current_piece.move_to!(x_position: piece_params[:x_position], y_position: piece_params[:y_position])
    end
    redirect_to game_path(@game)
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
