# frozen_string_literal: true

# Create table for words
class CreateWords < ActiveRecord::Migration[8.1]
  def change
    create_table :words, comment: 'Words' do |t|
      t.string :body, null: false
      t.integer :weight, null: false, default: 0
      t.timestamps
    end

    add_index :words, 'lower(body)', unique: true
  end
end
