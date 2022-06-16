class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :participants, dependent: :destroy
  has_many :communities, through: :participants
  has_many :posts, dependent: :destroy
  has_many :communities, through: :posts
  has_many :messages, dependent: :destroy

  has_many :active_friends, foreign_key: 'myself_id', class_name: 'Friend', dependent: :destroy
  has_many :passive_friends, foreign_key: 'partner_id', class_name: 'Friend', dependent: :destroy
  has_many :contact, through: :active_friends, source: :partner
  has_many :receive, through: :passive_friends, source: :myself

  has_one :message_read, dependent: :destroy

  after_create_commit :message_read_create

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
    passive_friends.find_by(myself_id: myself.id).destroy
  end

  def elimination(partner)
    active_friends.find_by(partner_id: partner.id).destroy
    passive_friends.find_by(myself_id: partner.id).destroy
  end

  def message_read_create
    user = User.last
    user.create_message_read!(user_id: user.id, message_read_last: 0)
  end

  def self.push_message(current_user)
    messages = Message.where(destination: current_user.id).order(created_at: "DESC")
    messages = 0 unless messages.present?
    if current_user.message_read.message_read_last < messages[0]
      current_user.message_read.message_read_last = messages[0]
      current_user.message_read.update
      return true
    end
  end
end
