class GamesController < ApplicationController
  before_action :authenticate_user!
  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to communities_path, notice: "登録しました"
    else
      render :new
    end
  end

  private

  def game_params
    params.require(:game).permit(:name, :info)
  end
end
