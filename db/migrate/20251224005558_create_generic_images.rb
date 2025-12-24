# frozen_string_literal: true

# Create table for generic dream images
class CreateGenericImages < ActiveRecord::Migration[8.1]
  # rubocop:disable Metrics/MethodLength
  def change
    create_table :generic_images, comment: 'Generic dream images' do |t|
      t.references :language, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.uuid :uuid, null: false, index: { unique: true }
      t.string :name, null: false, comment: 'Normalized name'
      t.string :summary, comment: 'Summary interpretation for dreambook'
      t.text :description, comment: 'Thorough interpretation for dreambook'
      t.integer :dreams_count, null: false, default: 0, comment: 'Wordform-agnostic dream count'
      t.integer :weight, null: false, default: 0, comment: 'Wordform-aware dream count'

      t.timestamps
    end

    add_index :generic_images, 'language_id, lower(name)', unique: true
  end

  # rubocop:enable Metrics/MethodLength
end
