module Games
  class Winner
    attr_reader :player_move, :bot_move

    def initialize(player_move, bot_move)
      @player_move = player_move
      @bot_move = bot_move
    end

    def call
      winner
    end

    private

    def winner
      return 'tie' if player_move == bot_move

      case player_move
      when 'rock'
        bot_move == 'scissors' ? 'player' : 'machine'
      when 'paper'
        bot_move == 'rock' ? 'player' : 'machine'
      when 'scissors'
        bot_move == 'paper' ? 'player' : 'machine'
      end
    end
  end
end
