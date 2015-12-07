class GamesController < ApplicationController
  # before_action :authenticate_user!

  def show
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to game_path(@game)
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def update
    current_game.update_attributes(game_params)
    redirect_to game_path(@game)
  end

  private

  helper_method :current_game
  def current_game
    @current_game ||= Game.where(id: params[:id]).last
  end

  def game_params
    params.require(:game).permit(:name, :white_player_id, :black_player_id)
  end

end
