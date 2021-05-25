require 'rails_helper'

RSpec.describe "Games", type: :request do
  describe "POST /games/play" do
    it "should return not found if user does not exist" do
      post "/games/play"
      expect(response).to have_http_status(:not_found)
      expect(response_message).to eq('User not found')
    end

    it "should return ok if user exists" do
      p = Player.create(name: 'John')
      post "/games/play", params: { name: p.name, move: 'paper' }
      expect(response).to have_http_status(:ok)
    end

    it "shoud return the result with the moves and the winner" do
      p = Player.create(name: 'John')
      post "/games/play", params: { name: p.name, move: 'scissors' }

      expect(response_json['moves'][0].keys).to include("name", "move")
      expect(response_json['moves'][0]['name']).to include("John")
      expect(response_json['moves'][0]['move']).to include("scissors")

      expect(response_json['moves'][1].keys).to include("name", "move")
      expect(response_json['moves'][1]['name']).to include("Bot")

      result = response_json['result']
      expect(['Bot wins', 'Tie', 'John wins']).to include(result)

      game_status = result.include?('wins') ? 'finished' : 'started'
      expect(Game.count).to eq(1)
      expect(Game.last.status).to eq(game_status)
    end

    it "should continue an existing game" do
      p = Player.create(name: 'Sophie')
      moves = [player_move, bot_move]
      Game.create(player_id: p.id, moves: moves)

      post "/games/play", params: { name: p.name, move: 'scissors' }
      expect(Game.count).to eq(1)
      expect(Game.last.moves.count).to be > 2
    end

    it "should create a second game after a finished one" do
      p = Player.create(name: 'Anthony')
      moves = [player_move('scissors'), bot_move]
      Game.create(player_id: p.id, moves: moves, status: 1)
      expect(Game.count).to eq(1)

      post "/games/play", params: { name: p.name, move: 'rock' }
      expect(Game.count).to eq(2)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/games"
      expect(response).to have_http_status(:success)
    end

    it "should respond to games and metadata" do
      get "/games"
      expect(response_json).to include('games')
      expect(response_json).to include('meta')
    end

    it "should return a list of paginated games" do
      p = Player.create(name: 'Marcellus')
      10.times do
        moves = [player_move(random_move), bot_move(random_move)]
        Game.create!(player_id: p.id, status: 1, moves: moves, player_wins: [true, false].sample)
      end

      get "/games"
      expect(response_json['games']).to be_a Array
      expect(response_json['games'].length).to eq(5)
      expect(response_json['games'][0].keys).to include('game_result', 'moves_list', 'played_at')
    end

    it "should return the second page games" do
      p = Player.create(name: 'Marcellus')
      10.times do
        moves = [player_move(random_move), bot_move(random_move)]
        Game.create!(player_id: p.id, status: 1, moves: moves, player_wins: [true, false].sample)
      end

      get "/games?page=2&per_page=2"
      expect(response_json['games'].length).to eq(2)
      expect(response_json['meta']['current_page']).to eq(2)
      expect(response_json['meta']['prev_page']).to eq(1)
      expect(response_json['meta']['next_page']).to eq(3)
      expect(response_json['meta']['total_count']).to eq(10)
    end
  end

  private

  def response_json
    JSON.parse(response.body)
  end

  def response_message
    response_json["message"]
  end

  def player_move(move = 'paper')
    {
      name: 'John',
      move: move,
      moved_at: Time.zone.now
    }
  end

  def bot_move(move = 'paper')
    {
      name: 'Bot',
      move: move,
      moved_at: Time.zone.now
    }
  end

  def random_move
    Game::MOVES.sample
  end
end
