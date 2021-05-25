class GamesController < ApplicationController
  DEFAULT_PAGE = 1
  PER_PAGE = 5

  def index
    games = Game.all.paginate(
      page: params[:page] || DEFAULT_PAGE,
      per_page: params[:per_page] || PER_PAGE
    )

    render json: games, each_serializer: GameSerializer, meta: pagination(games)
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

  def pagination(collection)
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.previous_page,
      total_pages: collection.total_pages,
      total_count: collection.total_entries
    }
  end
end
