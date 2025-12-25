# frozen_string_literal: true

# Create table for word forms
class CreateWordForms < ActiveRecord::Migration[8.1]
  # rubocop:disable Rails/CreateTableWithTimestamps
  def change
    create_table :word_forms, comment: 'Word forms' do |t|
      t.references :lexeme, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :word, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.boolean :defective, null: false, default: false, comment: 'Word has errors/mistypes'
    end

    add_index :word_forms, %i[lexeme_id word_id], unique: true
  end

  # rubocop:enable Rails/CreateTableWithTimestamps
end
