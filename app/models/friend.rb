class Friend < ApplicationRecord
  belongs_to :myself, class_name: "User"
  belongs_to :partner, class_name: "User"
  has_many :messages, dependent: :destroy

  # def self.friend_search(friends, name_search)
  #   friends.each do |friend|
  #     @partners.store(friend.partner)
  #   end
  #   @friends = @partners.where('name LIKE ?', "%#{name_search}")
  #   binding.irb
  # end

  # def friend_request!(partner)
  #   active_friends.create!(request: false, partner_id: partner.id)
  # end
  #
  # def friend_accept!(partner)
  #   active_friends.create!(request: true, partner_id: partner.id)
  # end
  #
  # def friendly?(partner)
  #   active_friends.find_by(partner_id: partner.id)
  # end
  #
  # def unfriend(partner)
  #   active_friends.find_by(partner_id: partner.id).destroy
  # end
end
