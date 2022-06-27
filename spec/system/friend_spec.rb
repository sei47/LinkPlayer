require 'rails_helper'
# bundle exec rspec spec/system/friend_spec.rb
RSpec.describe 'フレンド機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @second_user = FactoryBot.create(:second_user)
    @game = FactoryBot.create(:game, name: "DDD")
    @community = FactoryBot.create(:community, name: "ABC")
    visit new_user_session_path
    fill_in 'user[email]', with:'aaaaaa@email.com'
    fill_in 'user[password]', with: 'aaaaaa@email.com'
    click_on 'commit'
  end
  describe '新規作成' do
    before do
      @user.active_friends.create!(request: false, partner_id: @second_user.id)
      visit new_friend_path
      click_on 'ログアウト'
      visit new_user_session_path
      fill_in 'user[email]', with:'bbbbbb@email.com'
      fill_in 'user[password]', with: 'bbbbbb@email.com'
      click_on 'commit'
    end
    context 'フレンド申請した場合' do
      it '相手に承認ボタンが表示される' do
        expect(page).to have_content 'A'
      end
    end
    context '承認ボタンを押した場合' do
      it '申請相手のユーザーとフレンドになる' do
        click_on 'フレンド承認'
        visit friends_path
        expect(page).to have_content 'A'
      end
    end
  end
  describe 'フレンド解除機能' do
    before do
      @user.active_friends.create!(request: false, partner_id: @second_user.id)
      visit new_friend_path
      click_on 'ログアウト'
      visit new_user_session_path
      fill_in 'user[email]', with:'bbbbbb@email.com'
      fill_in 'user[password]', with: 'bbbbbb@email.com'
      click_on 'commit'
      click_on 'フレンド承認'
      visit friends_path
    end
    context 'フレンド解除ボタンを押した場合' do
      it '相手とのフレンドが解除される' do
        click_on '解除する'
        expect(page).not_to have_content 'A'
      end
    end
  end
end
