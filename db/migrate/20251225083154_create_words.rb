# frozen_string_literal: true

# Create table for words
class CreateWords < ActiveRecord::Migration[8.1]
  def change
    create_table :words, comment: 'Words' do |t|
      t.string :body, null: false
      t.integer :dreams_count, null: false, default: 0, comment: 'Dream count without repetition'
      t.integer :weight, null: false, default: 0, comment: 'Weight (repetitive use in dreams)'
      t.timestamps
    end

    add_index :words, 'lower(body)', unique: true
  end
end
