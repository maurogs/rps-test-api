class GamesController < ApplicationController
  def index
  end

  def play
    if current_player
      result = Games::Play.new(
        current_game,
        play_params[:name],
        play_params[:move]
      ).call

      render json: result
    else
      render json: { message: 'User not found' }, status: :not_found
    end
  end

  private

  def current_game
    @current_game ||= Game.where(
      status: 'started',
      player_id: current_player.id
    ).last || new_game
  end

  def new_game
    Game.new(player_id: current_player.id)
  end

  def current_player
    @current_player ||= Player.find_by(name: play_params[:name])
  end

  def play_params
    params.permit(:name, :move)
  end
end
