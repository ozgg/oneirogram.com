# frozen_string_literal: true

# Create table for lexemes
class CreateLexemes < ActiveRecord::Migration[8.1]
  def change
    create_table :lexemes, comment: 'Lexemes' do |t|
      t.references :language, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.string :body, null: false
      t.integer :dreams_count, null: false, default: 0, comment: 'Dream count without repetitions'
      t.integer :weight, null: false, default: 0, comment: 'Weight (repetition used in dreams)'
      t.timestamps
    end

    add_index :lexemes, %i[language_id body], unique: true
  end
end
