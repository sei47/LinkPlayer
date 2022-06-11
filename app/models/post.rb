class Post < ApplicationRecord
  validates :content, presence: true

  belongs_to :user
  belongs_to :community

  mount_uploader :image, ImageUploader
end
