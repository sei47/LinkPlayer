require 'rails_helper'
# bundle exec rspec spec/system/user_spec.rb
RSpec.describe 'ユーザーログイン機能', type: :system do
  describe '新規作成機能' do
    context 'ユーザーを新規作成した場合' do
      it 'ユーザーページが表示される' do
        visit new_user_registration_path
        fill_in 'user[name]', with:'A'
        fill_in 'user[email]', with:'123456@email.com'
        fill_in 'user[password]', with: '123456@email.com'
        fill_in 'user[password_confirmation]', with: '123456@email.com'
        click_on 'アカウント登録'
        expect(page).to have_content '参加コミュニティ一覧'
      end
    end
  end
  describe 'ログイン管理機能' do
    context 'ログインせずユーザーページに遷移しようとした場合' do
      it 'ログイン画面に遷移する' do
        @user = FactoryBot.create(:user)
        visit user_path(@user.id)
        expect(current_path).to eq "/users/sign_in"
      end
    end

    context 'ログインした場合' do
      before do
        @user = FactoryBot.create(:user)
        FactoryBot.create(:second_user)
        visit new_user_session_path
        fill_in 'user[email]', with:'aaaaaa@email.com'
        fill_in 'user[password]', with: 'aaaaaa@email.com'
        click_on 'commit'
      end
      it "ユーザーページが表示される" do
        expect(current_path).to eq user_path(@user.id)
      end
    end
    context 'ログアウトボタンを押した場合' do
      before do
        @user = FactoryBot.create(:user)
        FactoryBot.create(:second_user)
        visit new_user_session_path
        fill_in 'user[email]', with:'aaaaaa@email.com'
        fill_in 'user[password]', with: 'aaaaaa@email.com'
        click_on 'commit'
      end
      it "ログアウトできる" do
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe '管理ユーザー機能' do
    before do
      @test = FactoryBot.create(:user)
      @common = FactoryBot.create(:second_user)
      @community = FactoryBot.create(:community)
      visit new_user_session_path
      fill_in 'user[email]', with:'aaaaaa@email.com'
      fill_in 'user[password]', with: 'aaaaaa@email.com'
      click_on 'commit'
    end
    context '管理画面にアクセスした場合' do
      it '管理画面を表示できる' do
        click_on '管理画面へ'
        expect(current_path).to eq rails_admin_path
      end
    end

    context '管理ユーザーはコミュニティを作成したユーザーでなくとも' do
      it 'コミュニティの情報が編集できる' do
        visit edit_community_path(@community.id)
        fill_in 'community_name', with:'D'
        click_on '更新する'
        expect(page).to have_content 'D'
      end

      it 'コミュニティの削除ができる' do
        visit communities_path
        click_on '削除する'
        expect(page).to have_content '削除しました'
      end
    end
  end
end
