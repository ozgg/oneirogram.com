# frozen_string_literal: true

# Create table for Browser model
class CreateBrowsers < ActiveRecord::Migration[8.1]
  def change
    create_table :browsers, comment: 'Browsers' do |t|
      t.string :name, collation: 'C', null: false, index: { unique: true }, comment: 'User Agent'
      t.timestamps
    end
  end
end
