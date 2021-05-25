require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:player) { Player.create(name: 'Alex') }
  let(:game) { Game.create(player_id: player.id) }

  it 'should create a new game object' do
    expect(game).to be_a Game
  end

  it 'should respond to his fields' do
    expect(game).to respond_to(:status)
    expect(game).to respond_to(:moves)
    expect(game).to respond_to(:player_wins)
    expect(game).to respond_to(:player_id)

    expect(game.status).to eq('started')
    expect(game.moves).to be_a Array
    expect(game.player_wins).to be false
    expect(game.player_id).not_to be_nil
    expect(game.player_id).to eq(player.id)
  end

  it 'should save valid statuses' do
    expect(game.valid?).to be true
    expect(game.status).to eq('started')

    game.status = 'finished'

    expect(game.valid?).to be true
    expect(game.status).to eq('finished')
  end

  it 'should not save moves with invalid keys' do
    move = {  user: player,
              move: 'rock',
              moved_at: Time.zone.now }
    game.moves = [move]

    expect(game.valid?).to be false
    expect(game.errors.messages[:moves]).to include('Invalid key')
  end

  it 'should not save moves with invalid move to play' do
    move = {  name: 'Bot',
              move: 'bad movement',
              moved_at: Time.zone.now }
    game.moves = [move]

    expect(game.valid?).to be false
    expect(game.errors.messages[:moves]).to include('Invalid move')
  end
end
