# frozen_string_literal: true

# Create table for lexemes in dreams
class CreateDreamLexemes < ActiveRecord::Migration[8.1]
  def change
    create_table :dream_lexemes, comment: 'Lexemes used in dreams' do |t|
      t.references :dream, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :lexeme, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.timestamps
    end

    add_index :dream_lexemes, %i[dream_id lexeme_id], unique: true
  end
end
