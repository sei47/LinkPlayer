class Game < ApplicationRecord
  validates :name, presence: true
  validates :info, presence: true
  has_many :communities
end
