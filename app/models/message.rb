class Message < ApplicationRecord
  validates :message, presence: true
  belongs_to :friend
  belongs_to :user
  mount_uploader :message_image, ImageUploader
end
