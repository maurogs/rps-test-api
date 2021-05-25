require 'rails_helper'

RSpec.describe Player, type: :model do
  let(:player) { Player.create(name: 'Marc') }
  let(:another_player) { Player.create(name: 'Max') }

  it 'should create a new player object' do
    expect(player).to be_a Player
  end

  it 'should respond to the name field' do
    expect(player).to respond_to(:name)
    expect(another_player).to respond_to(:name)

    expect(player.name).to eq('Marc')
    expect(another_player.name).to eq('Max')
  end

  it 'should not create a user with an existing name' do
    invalid_player = Player.new(name: 'Max')

    expect(player.valid?).to be true
    expect(another_player.valid?).to be true

    expect(invalid_player.valid?).to be false
    expect(invalid_player.errors.messages[:name]).to include('Player name should be unique')
  end

  it 'should not create a user with a bot name' do
    invalid_player = Player.new(name: 'bot')
    message = 'Player name should be different than Bot'

    expect(invalid_player.valid?).to be false
    expect(invalid_player.errors.messages[:name]).to include(message)

    invalid_player.name = 'Bot'
    expect(invalid_player.valid?).to be false
    expect(invalid_player.errors.messages[:name]).to include(message)

    invalid_player.name = 'BOT'
    expect(invalid_player.valid?).to be false
    expect(invalid_player.errors.messages[:name]).to include(message)
  end
end
