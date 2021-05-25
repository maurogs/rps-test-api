class Player < ApplicationRecord
  BLACKLIST_NAMES = %w(bot Bot BOT).freeze
  validates :name, uniqueness: { message: 'Player name should be unique' }
  validate :blacklist_names

  private

  def blacklist_names
    return unless BLACKLIST_NAMES.include?(name)

    errors.add(:name, 'Player name should be different than Bot')
  end
end
