# frozen_string_literal: true

# Create table for dreams
class CreateDreams < ActiveRecord::Migration[8.1]
  # rubocop:disable Metrics/MethodLength
  def change
    create_table :dreams, comment: 'Dreams' do |t|
      t.uuid :uuid, null: false, index: { unique: true }
      t.references :user, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :sleep_place, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.references :language, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.integer :lucidity, limit: 2, default: 0, null: false, comment: '0 (non-lucid at all) to 5 (lucid)'
      t.integer :privacy, limit: 2, default: 0, null: false, comment: 'Generally accessible/for community/personal'
      t.string :title
      t.text :body, null: false
      t.timestamps
      t.integer :comment_count, null: false, default: 0, comment: 'Number of comments'
    end

    add_index :dreams, "date_trunc('month', created_at)", name: 'dreams_created_month_idx'
  end

  # rubocop:enable Metrics/MethodLength
end
