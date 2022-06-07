class Community < ApplicationRecord
  belongs_to :game
  has_many :community_tags, dependent: :destroy
  has_many :tags, through: :community_tags

  mount_uploader :icon, ImageUploader
end
