require 'rails_helper'
# bundle exec rspec spec/system/community_spec.rb
RSpec.describe 'コミュニティ機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @game = FactoryBot.create(:game, name: "DDD")
    @community = FactoryBot.create(:community, name: "ABC")
    FactoryBot.create(:community, name: "DEF", game_id: @community.game_id)
    FactoryBot.create(:tag, name: "CCC")
    visit new_user_session_path
    fill_in 'user[email]', with:'aaaaaa@email.com'
    fill_in 'user[password]', with: 'aaaaaa@email.com'
    click_on 'commit'
  end
  describe '新規作成機能' do
    context 'コミュニティを新規作成した場合' do
      it '作成したコミュニティが表示される' do
        visit new_community_path
        fill_in 'community[name]', with:'community_test'
        fill_in 'community[comment]', with:'comment'
        select 'DDD', from: 'community[game_id]'
        check 'CCC'
        click_on 'commit'
        expect(page).to have_content 'community_test'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのコミュニティ一覧が表示される' do
        visit new_community_path
        fill_in 'community[name]', with:'AAA'
        fill_in 'community[comment]', with:'comment'
        select 'DDD', from: 'community[game_id]'
        check 'CCC'
        click_on 'commit'
        visit communities_path
        expect(page).to have_content 'AAA'
      end
    end

    context 'コミュニティ一覧でタイトル検索をした場合' do
      it "一致したコミュニティが表示される" do
        visit communities_path
        fill_in 'q[name_cont]', with:'A'
        click_on 'commit'
        expect(page).not_to have_content 'DEF'
      end
    end

    context 'タグを選択して検索を押した場合' do
      it "一致したコミュニティが表示される" do
        visit new_community_path
        fill_in 'community[name]', with:'community_test'
        fill_in 'community[comment]', with:'comment'
        select 'DDD', from: 'community[game_id]'
        check 'CCC'
        click_on 'commit'

        visit communities_path
        select 'CCC', from: 'q[tags_id_eq]'
        click_on 'commit'
        expect(page).not_to have_content 'ABC'
      end
    end
  end
  describe '参加機能' do
    context 'コミュニティの詳細画面で参加ボタンを押した場合' do
      it 'そのコミュニティに参加できる' do
        visit community_path(@community.id)
        click_on 'コミュニティ参加'
        expect(page).to have_content '参加しました'
      end
    end
    context 'コミュニティの詳細画面で脱退ボタンを押した場合' do
      it 'コミュニティから脱退できる' do
        visit community_path(@community.id)
        click_on 'コミュニティ参加'
        click_on 'コミュニティ脱退'
        expect(page).to have_content '脱退しました'
      end
    end
    # context '参加したコミュニテに移動した場合' do
    #   it '投稿することができる' do
    #     visit community_path(@community.id)
    #     click_on 'コミュニティ参加'
    #     fill_in 'post_content', with:'bob'
    #     click_on '投稿する'
    #     expect(page).to have_content 'bob'
    #   end
    # end
  end
end
