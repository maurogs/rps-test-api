class Game < ApplicationRecord
  MOVES = %w(rock paper scissors).freeze
  belongs_to :player

  enum status: { started: 0, finished: 1 }

  validates :status, presence: true, inclusion: { in: Game.statuses.keys }
  validate :moves_fields

  private

  def moves_fields
    return unless moves.is_a? Array

    moves.each do |move|
      valid_move_keys(move.stringify_keys)
      valid_move_to_play(move.stringify_keys)
    end
  end

  def valid_move_keys(move)
    return if (%w(name move moved_at) - move.keys).empty?

    errors.add(:moves, 'Invalid key')
  end

  def valid_move_to_play(move)
    return if MOVES.include?(move['move'])

    errors.add(:moves, 'Invalid move')
  end
end
