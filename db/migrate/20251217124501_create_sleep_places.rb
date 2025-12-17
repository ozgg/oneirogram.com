# frozen_string_literal: true

# Create table for sleep places
class CreateSleepPlaces < ActiveRecord::Migration[8.1]
  def change
    create_table :sleep_places, comment: 'Places where dreams are seen' do |t|
      t.uuid :uuid, null: false, index: { unique: true }
      t.references :user, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.integer :dreams_count, default: 0, null: false
      t.string :name, null: false
      t.timestamps
    end

    add_index :sleep_places, 'user_id, lower(name)', unique: true
  end
end
