# frozen_string_literal: true

# Create table for linking dreams and generic dream images
class CreateDreamGenericImages < ActiveRecord::Migration[8.1]
  def change
    create_table :dream_generic_images, comment: 'Links between dreams and generic dream images' do |t|
      t.references :dream, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :generic_image, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.string :summary, null: false
      t.timestamps
    end

    add_index :dream_generic_images, %i[dream_id generic_image_id], unique: true
  end
end
