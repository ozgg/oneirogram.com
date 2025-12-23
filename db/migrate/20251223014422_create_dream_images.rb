# frozen_string_literal: true

# Create table for personal dream images
class CreateDreamImages < ActiveRecord::Migration[8.1]
  def change
    create_table :dream_images, comment: 'Personal dream image' do |t|
      t.uuid :uuid, null: false, index: { unique: true }
      t.references :user, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.integer :dreams_count, null: false, default: 0
      t.string :name, null: false
      t.timestamps
    end

    add_index :dream_images, %i[user_id name], unique: true
  end
end
