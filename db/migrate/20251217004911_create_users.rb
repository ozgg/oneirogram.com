# frozen_string_literal: true

# Create table for User model
class CreateUsers < ActiveRecord::Migration[8.1]
  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def change
    create_table :users, comment: 'Users' do |t|
      t.uuid :uuid, null: false, index: { unique: true }
      t.string :slug, collation: 'C', null: false, comment: 'Slug (case-insensitive)'
      t.string :email, collation: 'C', comment: 'Primary email'
      t.bigint :inviter_id, comment: 'Who invited this user'
      t.boolean :super_user, null: false, default: false, comment: 'User has unlimited privileges'
      t.boolean :active, null: false, default: true, comment: 'User is allowed to log in'
      t.boolean :bot, null: false, default: false, comment: 'User can be handled as bot'
      t.boolean :email_confirmed, null: false, default: false, comment: 'Email is confirmed'
      t.string :password_digest, null: false, comment: 'Encrypted password'
      t.string :notice, comment: 'Administrative notice'
      t.string :referral_code, index: { unique: true }, comment: 'Referral code'
      t.datetime :deleted_at, comment: 'When user was deleted'
      t.jsonb :profile, null: false, default: {}, comment: 'Profile'
      t.jsonb :settings, null: false, default: {}, comment: 'Settings'
      t.timestamps
    end

    add_foreign_key :users, :users, column: :inviter_id, on_update: :cascade, on_delete: :nullify
    add_index :users, 'lower(slug)', unique: true
    add_index :users, 'lower(email)', unique: true
  end

  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
end
