class Comment < ApplicationRecord
    belongs_to :item, dependent: :destroy
    belongs_to :user_profile, dependent: :destroy
  
    validates :comment_message, length: {minmum: 10}
end
  