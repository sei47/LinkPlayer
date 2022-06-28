class Tag < ApplicationRecord
  has_many :community_tags, dependent: :destroy
  has_many :communities, through: :community_tags
  validates :name, uniqueness: true
end
