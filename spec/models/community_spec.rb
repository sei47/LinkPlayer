require 'rails_helper'

describe 'コミュニティモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'コミュニティのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        community = Community.new(name: '', comment: '失敗テスト')
        expect(community).not_to be_valid
      end
    end
    context 'コミュニティの概要が空の場合' do
      it 'バリデーションにひっかかる' do
        community = Community.new(name: '失敗テスト', comment: '')
        expect(community).not_to be_valid
      end
    end
  end
end
