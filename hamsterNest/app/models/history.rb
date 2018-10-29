class History < ApplicationRecord
  belongs_to :item
  belogns_to :user_profile
end
