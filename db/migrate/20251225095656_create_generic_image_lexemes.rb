# frozen_string_literal: true

# Create table for linking generic dream images and lexemes
class CreateGenericImageLexemes < ActiveRecord::Migration[8.1]
  def change
    create_table :generic_image_lexemes, comment: 'Lexemes for generic dream images' do |t|
      t.references :generic_image, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :lexeme, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.timestamps
    end

    add_index :generic_image_lexemes, %i[generic_image_id lexeme_id], unique: true
  end
end
