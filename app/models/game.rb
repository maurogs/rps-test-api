class Game < ApplicationRecord
  belongs_to :player

  enum status: { started: 0, finished: 1 }
end
