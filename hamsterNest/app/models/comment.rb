class Comment < ApplicationRecord
  belongs_to :item
  belongs_to :user_profile

  validates :comment_message, length: {minimum: 10}
end
