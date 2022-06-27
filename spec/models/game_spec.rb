require 'rails_helper'

describe 'ゲームモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'ゲームのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        game = Game.new(name: '', info: '失敗テスト')
        expect(game).not_to be_valid
      end
    end
    context 'ゲームの説明が空の場合' do
      it 'バリデーションにひっかかる' do
        game = Game.new(name: '失敗テスト', info: '')
        expect(game).not_to be_valid
      end
    end
  end
end
