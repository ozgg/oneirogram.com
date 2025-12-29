# frozen_string_literal: true

# Comment
#
# Attributes:
#   body [Text]
#   browser_id [Browser]
#   created_at
#   commentable_uuid [UUID]
#   deleted_at [DateTime]
#   ip [inet]
#   parent_id [Comment]
#   updated_at [DateTime]
#   user_id [User]
#   uuid [UUID]
#   visible [Boolean]
class Comment < ApplicationRecord
  include HasUuid

  belongs_to :user, optional: true
  belongs_to :browser, optional: true
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :child_comments,
           class_name: 'Comment',
           foreign_key: :parent_id,
           inverse_of: :parent,
           dependent: :destroy

  validates :body,
            presence: true,
            length: { maximum: 5000 }
  validates :commentable_uuid, presence: true
end
