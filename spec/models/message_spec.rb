require 'rails_helper'

describe 'メッセージモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'メッセージの文章が空の場合' do
      it 'バリデーションにひっかる' do
        @user = FactoryBot.create(:user)
        @second_user = FactoryBot.create(:second_user)
        @friend = @user.active_friends.create!(request: true, partner_id: @second_user.id)
        @user.passive_friends.create!(request: true, myself_id: @second_user.id)
        @community = FactoryBot.create(:community)
        message = Message.new(friend_id: @friend.id, user_id: @second_user.id, message: '')
        expect(message).not_to be_valid
      end
    end
  end
end
