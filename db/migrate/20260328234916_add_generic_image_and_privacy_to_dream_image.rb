# frozen_string_literal: true

# Add privacy and generic image reference to dream image
class AddGenericImageAndPrivacyToDreamImage < ActiveRecord::Migration[8.1]
  def change
    add_reference :dream_images, :generic_image, foreign_key: { on_update: :cascade, on_delete: :nullify }
    add_column :dream_images,
               :privacy,
               :integer,
               limit: 2,
               null: false,
               default: 0,
               comment: 'Generally accessible/for community/personal'
  end
end
