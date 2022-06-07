class Tag < ApplicationRecord
  has_many :community_tags, dependent: :destroy
  has_many :community, through: :community_tags
end
