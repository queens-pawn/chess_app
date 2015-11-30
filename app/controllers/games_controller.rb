class GamesController < ApplicationController
  # before_action :authenticate_user!

  def show
    @game = Game.find(params[:id])
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
    @game = Game.find(params[:id])
    @game.update_attributes(game_params)
    redirect_to game_path(@game)
  end

  private

  def game_params
    params.require(:game).permit(:name, :white_player_id, :black_player_id)
  end

end
