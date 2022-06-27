require 'rails_helper'

describe '投稿モデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context '投稿のタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        @test = FactoryBot.create(:user)
        @community = FactoryBot.create(:community)
        post = Post.new(community_id: @community.id,user_id: @test.id, content: '')
        expect(post).not_to be_valid
      end
    end
  end
end
