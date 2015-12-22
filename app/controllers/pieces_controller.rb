class PiecesController < ApplicationController

  def update
    @game = current_piece.game
    current_piece.move_to!(x_position: piece_params[:x_position], y_position: piece_params[:y_position])
    render :text => 'updated!'
    # redirect_to game_path(@game)
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
