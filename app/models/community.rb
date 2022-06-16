class Community < ApplicationRecord
  validates :name, presence: true
  validates :comment, presence: true

  belongs_to :game

  has_many :community_tags, dependent: :destroy
  has_many :tags, through: :community_tags

  has_many :participants, dependent: :destroy
  has_many :join_users, through: :participants, source: :user
  has_many :posts, dependent: :destroy
  has_many :posting_users, through: :posts, source: :user

  mount_uploader :icon, IconUploader

  def community_participation(user)
    participants.create(user_id: user)
  end
  #
  # def community_secession(user)
  #   binding.irb
  #   participants.destroy(user_id: user)
  # end
end
