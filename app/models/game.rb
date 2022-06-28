class Game < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :info, presence: true
  has_many :communities
end
