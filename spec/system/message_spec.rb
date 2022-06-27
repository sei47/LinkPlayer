require 'rails_helper'
# bundle exec rspec spec/system/message_spec.rb
RSpec.describe 'メッセージ機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @second_user = FactoryBot.create(:second_user)
    @game = FactoryBot.create(:game, name: "DDD")
    @community = FactoryBot.create(:community, name: "ABC")
    @user.active_friends.create!(request: false, partner_id: @second_user.id)
    visit new_user_session_path
    fill_in 'user[email]', with:'bbbbbb@email.com'
    fill_in 'user[password]', with: 'bbbbbb@email.com'
    click_on 'commit'
    click_on 'フレンド承認'
    click_on 'ログアウト'
    visit new_user_session_path
    fill_in 'user[email]', with:'aaaaaa@email.com'
    fill_in 'user[password]', with: 'aaaaaa@email.com'
    click_on 'commit'
  end
  describe '新規作成' do
    before do
      visit new_message_path
      select 'B', from: 'message_partner_search'
      fill_in 'message[message]', with:'テストメッセージ'
      click_on 'commit'
    end
    context 'メッセージをフレンドに送信した場合' do
      it '送信一覧にメッセージが表示される' do
        expect(page).to have_content 'テストメッセージ'
      end
    end
  end
  describe '受信機能' do
    before do
      visit new_message_path
      select 'B', from: 'message[partner_search]'
      fill_in 'message[message]', with:'テストメッセージ'
      click_on 'commit'
      click_on 'ログアウト'
      visit new_user_session_path
      fill_in 'user[email]', with:'bbbbbb@email.com'
      fill_in 'user[password]', with: 'bbbbbb@email.com'
      click_on 'commit'
    end
    context 'フレンドからメッセージが送信された場合' do
      it '受信一覧にメッセージが表示される' do
        visit messages_path
        click_on '受信一覧へ'
        expect(page).to have_content 'テストメッセージ'
      end

      # it '通知が表示される' do
      # end
    end
  end
end
