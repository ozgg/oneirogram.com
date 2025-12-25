# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2025_12_25_093908) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "browsers", comment: "Browsers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false, collation: "C", comment: "User Agent"
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_browsers_on_name", unique: true
  end

  create_table "dream_generic_images", comment: "Links between dreams and generic dream images", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "dream_id", null: false
    t.bigint "generic_image_id", null: false
    t.string "summary", null: false
    t.datetime "updated_at", null: false
    t.index ["dream_id", "generic_image_id"], name: "index_dream_generic_images_on_dream_id_and_generic_image_id", unique: true
    t.index ["dream_id"], name: "index_dream_generic_images_on_dream_id"
    t.index ["generic_image_id"], name: "index_dream_generic_images_on_generic_image_id"
  end

  create_table "dream_image_dreams", comment: "Links between dreams and images", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "dream_id", null: false
    t.bigint "dream_image_id", null: false
    t.datetime "updated_at", null: false
    t.index ["dream_id", "dream_image_id"], name: "index_dream_image_dreams_on_dream_id_and_dream_image_id", unique: true
    t.index ["dream_id"], name: "index_dream_image_dreams_on_dream_id"
    t.index ["dream_image_id"], name: "index_dream_image_dreams_on_dream_image_id"
  end

  create_table "dream_images", comment: "Personal dream image", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "dreams_count", default: 0, null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.uuid "uuid", null: false
    t.index ["user_id", "name"], name: "index_dream_images_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_dream_images_on_user_id"
    t.index ["uuid"], name: "index_dream_images_on_uuid", unique: true
  end

  create_table "dream_words", comment: "Words used in dreams", force: :cascade do |t|
    t.bigint "dream_id", null: false
    t.integer "weight", limit: 2, default: 0, null: false, comment: "How many times used"
    t.bigint "word_id", null: false
    t.index ["dream_id", "word_id"], name: "index_dream_words_on_dream_id_and_word_id", unique: true
    t.index ["dream_id"], name: "index_dream_words_on_dream_id"
    t.index ["word_id"], name: "index_dream_words_on_word_id"
  end

  create_table "dreams", comment: "Dreams", force: :cascade do |t|
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.bigint "language_id"
    t.integer "lucidity", limit: 2, default: 0, null: false, comment: "0 (non-lucid at all) to 5 (lucid)"
    t.integer "privacy", limit: 2, default: 0, null: false, comment: "Generally accessible/for community/personal"
    t.bigint "sleep_place_id"
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.uuid "uuid", null: false
    t.index "date_trunc('month'::text, created_at)", name: "dreams_created_month_idx"
    t.index ["language_id"], name: "index_dreams_on_language_id"
    t.index ["sleep_place_id"], name: "index_dreams_on_sleep_place_id"
    t.index ["user_id"], name: "index_dreams_on_user_id"
    t.index ["uuid"], name: "index_dreams_on_uuid", unique: true
  end

  create_table "generic_images", comment: "Generic dream images", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description", comment: "Thorough interpretation for dreambook"
    t.integer "dreams_count", default: 0, null: false, comment: "Wordform-agnostic dream count"
    t.bigint "language_id", null: false
    t.string "name", null: false, comment: "Normalized name"
    t.string "summary", comment: "Summary interpretation for dreambook"
    t.datetime "updated_at", null: false
    t.uuid "uuid", null: false
    t.integer "weight", default: 0, null: false, comment: "Wordform-aware dream count"
    t.index "language_id, lower((name)::text)", name: "index_generic_images_on_language_id_lower_name", unique: true
    t.index ["language_id"], name: "index_generic_images_on_language_id"
    t.index ["uuid"], name: "index_generic_images_on_uuid", unique: true
  end

  create_table "languages", id: :serial, comment: "Languages", force: :cascade do |t|
    t.string "code", limit: 35, null: false, collation: "C", comment: "Locale code (IETF BCP 47 / RFC 4656)"
    t.index ["code"], name: "index_languages_on_code", unique: true
  end

  create_table "lexemes", comment: "Lexemes", force: :cascade do |t|
    t.string "body", null: false
    t.datetime "created_at", null: false
    t.integer "dreams_count", default: 0, null: false, comment: "Dream count without repetitions"
    t.bigint "language_id", null: false
    t.datetime "updated_at", null: false
    t.integer "weight", default: 0, null: false, comment: "Weight (repetition used in dreams)"
    t.index ["language_id", "body"], name: "index_lexemes_on_language_id_and_body", unique: true
    t.index ["language_id"], name: "index_lexemes_on_language_id"
  end

  create_table "sleep_places", comment: "Places where dreams are seen", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "dreams_count", default: 0, null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.uuid "uuid", null: false
    t.index "user_id, lower((name)::text)", name: "index_sleep_places_on_user_id_lower_name", unique: true
    t.index ["user_id"], name: "index_sleep_places_on_user_id"
    t.index ["uuid"], name: "index_sleep_places_on_uuid", unique: true
  end

  create_table "users", comment: "Users", force: :cascade do |t|
    t.boolean "active", default: true, null: false, comment: "User is allowed to log in"
    t.boolean "bot", default: false, null: false, comment: "User can be handled as bot"
    t.datetime "created_at", null: false
    t.datetime "deleted_at", comment: "When user was deleted"
    t.string "email", collation: "C", comment: "Primary email"
    t.boolean "email_confirmed", default: false, null: false, comment: "Email is confirmed"
    t.bigint "inviter_id", comment: "Who invited this user"
    t.string "notice", comment: "Administrative notice"
    t.string "password_digest", null: false, comment: "Encrypted password"
    t.jsonb "profile", default: {}, null: false, comment: "Profile"
    t.string "referral_code", comment: "Referral code"
    t.jsonb "settings", default: {}, null: false, comment: "Settings"
    t.string "slug", null: false, collation: "C", comment: "Slug (case-insensitive)"
    t.boolean "super_user", default: false, null: false, comment: "User has unlimited privileges"
    t.datetime "updated_at", null: false
    t.uuid "uuid", null: false
    t.index "lower((email)::text)", name: "index_users_on_lower_email", unique: true
    t.index "lower((slug)::text)", name: "index_users_on_lower_slug", unique: true
    t.index ["referral_code"], name: "index_users_on_referral_code", unique: true
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

  create_table "word_forms", comment: "Word forms", force: :cascade do |t|
    t.boolean "defective", default: false, null: false, comment: "Word has errors/mistypes"
    t.bigint "lexeme_id", null: false
    t.bigint "word_id", null: false
    t.index ["lexeme_id", "word_id"], name: "index_word_forms_on_lexeme_id_and_word_id", unique: true
    t.index ["lexeme_id"], name: "index_word_forms_on_lexeme_id"
    t.index ["word_id"], name: "index_word_forms_on_word_id"
  end

  create_table "words", comment: "Words", force: :cascade do |t|
    t.string "body", null: false
    t.datetime "created_at", null: false
    t.integer "dreams_count", default: 0, null: false, comment: "Dream count without repetition"
    t.datetime "updated_at", null: false
    t.integer "weight", default: 0, null: false, comment: "Weight (repetitive use in dreams)"
    t.index "lower((body)::text)", name: "index_words_on_lower_body", unique: true
  end

  add_foreign_key "dream_generic_images", "dreams", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dream_generic_images", "generic_images", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dream_image_dreams", "dream_images", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dream_image_dreams", "dreams", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dream_images", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dream_words", "dreams", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dream_words", "words", on_update: :cascade, on_delete: :cascade
  add_foreign_key "dreams", "languages", on_update: :cascade, on_delete: :nullify
  add_foreign_key "dreams", "sleep_places", on_update: :cascade, on_delete: :nullify
  add_foreign_key "dreams", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "generic_images", "languages", on_update: :cascade, on_delete: :cascade
  add_foreign_key "lexemes", "languages", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sleep_places", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "users", "users", column: "inviter_id", on_update: :cascade, on_delete: :nullify
  add_foreign_key "word_forms", "lexemes", on_update: :cascade, on_delete: :cascade
  add_foreign_key "word_forms", "words", on_update: :cascade, on_delete: :cascade
end
