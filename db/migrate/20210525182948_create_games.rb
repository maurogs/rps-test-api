class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.integer :status, limit: 1, default: 0
      t.jsonb :moves, default: []
      t.boolean :player_wins, default: false
      t.references :player, null: false, index: true

      t.timestamps
    end
  end
end
