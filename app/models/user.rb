class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :participants
  has_many :communities, through: :participants
  has_many :posts
  has_many :communities, through: :posts

  has_many :active_friends, foreign_key: 'myself_id', class_name: 'Friend', dependent: :destroy
  has_many :passive_friends, foreign_key: 'partner_id', class_name: 'Friend', dependent: :destroy
  has_many :contact, through: :active_friends, source: :partner
  has_many :receive, through: :passive_friends, source: :myself

  def friend_request!(partner)
    active_friends.create!(request: false, partner_id: partner.id)
  end

  def friend_accept!(partner)
    active_friends.create!(request: true, partner_id: partner.id)
  end

  def friendly?(partner)
    active_friends.find_by(partner_id: partner.id)
  end

  def unfriend(myself)
    binding.irb
    passive_friends.find_by(myself_id: myself.id).destroy
  end

  def elimination(partner)
    active_friends.find_by(partner_id: partner.id).destroy
    passive_friends.find_by(myself_id: partner.id).destroy
  end
end
