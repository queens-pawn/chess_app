class PiecesController < ApplicationController

  def update
    @game = current_piece.game
    if current_piece.valid_move?(piece_params[:x_position].to_i, piece_params[:y_position].to_i)
      current_piece.move_to!(x_position: piece_params[:x_position], y_position: piece_params[:y_position])
      render :text => 'valid move', :status => :ok
    else
      render :text => 'invalid move', :status => :bad_request
    end
    
  end


def update
   @game = current_piece.game
   if current_piece.valid_move?(piece_params[:x_position].to_i, piece_params[:y_position].to_i) && !current_piece.is_obstructed?(piece_params[:x_position].to_i, piece_params[:y_position].to_i)
     current_piece.move_to!(x_position: piece_params[:x_position], y_position: piece_params[:y_position])
     render :text => 'valid move', :status => :ok
   else
     render :text => 'invalid move', :status => :bad_request
   end

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
