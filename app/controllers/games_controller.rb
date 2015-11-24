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

  private

  def game_params
    params.require(:game).permit(:name)  	
  end

end