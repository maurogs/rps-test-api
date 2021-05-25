module Games
  class Play
    attr_accessor :game

    def initialize(game, name, move)
      @game = game
      @name = name
      @move = move
    end

    def call
      add_moves
      complete_game
      game.save

      result
    end

    private

    def result
      {
        moves: [
          player_move.except(:moved_at),
          bot_move.except(:moved_at)
        ],
        result: winner
      }
    end

    def winner
      return "#{@name.capitalize} wins" if game_result == 'player'
      return 'Bot wins' if game_result == 'machine'

      'Tie'
    end

    def game_result
      Games::Winner.new(player_move[:move], bot_move[:move]).call
    end

    def complete_game
      return if game_result == 'tie'

      game.player_wins = game_result == 'player'
      game.status = 'finished'
    end

    def add_moves
      game.moves += [player_move, bot_move]
    end

    def player_move
      { name: @name, move: @move, moved_at: moved_at }
    end

    def bot_move
      { name: 'Bot', move: random_move, moved_at: moved_at }
    end

    def random_move
      @random_move ||= Game::MOVES.sample
    end

    def moved_at
      @moved_at ||= Time.zone.now
    end
  end
end
