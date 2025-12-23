# frozen_string_literal: true

# Create table for linking dreams with dream images
class CreateDreamImageDreams < ActiveRecord::Migration[8.1]
  def change
    create_table :dream_image_dreams, comment: 'Links between dreams and images' do |t|
      t.references :dream_image, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :dream, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.timestamps
    end

    add_index :dream_image_dreams, %i[dream_id dream_image_id], unique: true
  end
end
