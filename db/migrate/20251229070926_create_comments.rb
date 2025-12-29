# frozen_string_literal: true

# Create table for comments
class CreateComments < ActiveRecord::Migration[8.1]
  # rubocop:disable Metrics/MethodLength
  def change
    create_table :comments, comment: 'Comments' do |t|
      t.uuid :uuid, null: false, index: { unique: true }
      t.bigint :parent_id, index: true
      t.uuid :commentable_uuid, null: false, index: true, comment: 'Commented object'
      t.references :user, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.references :browser, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.inet :ip
      t.boolean :visible, null: false, default: true
      t.text :body, null: false
      t.datetime :deleted_at
      t.timestamps
    end

    add_foreign_key :comments, :comments, column: :parent_id, on_update: :cascade, on_delete: :cascade
  end

  # rubocop:enable Metrics/MethodLength
end
