class Game < ApplicationRecord
  MOVES = %w(rock paper scissors).freeze
  belongs_to :player

  enum status: { started: 0, finished: 1 }
end
