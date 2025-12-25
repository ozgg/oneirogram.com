# frozen_string_literal: true

# Create table for word usage in dreams
class CreateDreamWords < ActiveRecord::Migration[8.1]
  # rubocop:disable Rails/CreateTableWithTimestamps
  def change
    create_table :dream_words, comment: 'Words used in dreams' do |t|
      t.references :dream, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :word, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.integer :weight, limit: 2, null: false, default: 0, comment: 'How many times used'
    end

    add_index :dream_words, %i[dream_id word_id], unique: true
  end

  # rubocop:enable Rails/CreateTableWithTimestamps
end
