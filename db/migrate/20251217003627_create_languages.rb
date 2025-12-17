# frozen_string_literal: true

# Migration for creating languages table
class CreateLanguages < ActiveRecord::Migration[8.1]
  # rubocop:disable Rails/DangerousColumnNames
  def change
    create_table :languages, id: false, comment: 'Languages' do |t|
      t.integer :id, limit: 2, null: false, primary_key: true
      t.string :code,
               limit: 35,
               collation: 'C',
               null: false,
               index: { unique: true },
               comment: 'Locale code (IETF BCP 47 / RFC 4656)'
    end
  end

  # rubocop:enable Rails/DangerousColumnNames
end
