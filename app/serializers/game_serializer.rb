class GameSerializer < ActiveModel::Serializer
  attributes :moves_list, :game_result, :played_at

  def moves_list
    object.moves.map { |move| move.except('moved_at') }
  end

  def game_result
    object.player_wins ? 'Player wins' : 'Bot wins'
  end

  def played_at
    object.created_at
  end
end
