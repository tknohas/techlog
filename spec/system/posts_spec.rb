require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let(:user) { create(:user) }
  let!(:post) { create(:post, user_id: user.id) }
  let(:post1) { create(:post, user_id: user.id) }
  before do
    driven_by(:rack_test)
  end

  describe "ログ投稿機能" do
    context "ログインしていない場合" do
      it "ログインページへリダイレクトされる" do
        visit new_post_path
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content "ログインしてください。"
      end
    end

    context "ログインしている場合" do
      before do
        sign_in user
        visit new_post_path
      end
      it "ログインページへリダイレクトされない" do
        expect(current_path).to_not eq new_user_session_path
      end
      it "投稿できる" do
        fill_in 'post_title', with: post.title
        fill_in 'post_content', with: post.content
        click_on 'ログを記録'
        expect(page).to have_content('投稿しました')
        expect(current_path).to eq posts_path
      end
      it 'Postを作成できない' do
        visit new_post_path
        fill_in 'post_title', with: ""
        fill_in 'post_content', with: post.content
        click_on 'ログを記録'
        visit root_path
        expect(page).to have_content('投稿に失敗しました')
      end
    end
  end

  describe "ログ詳細機能の検証" do
    before do
      visit post_path(post.id)
    end
      it "詳細が表示される" do
        expect(page).to have_content post.title
        expect(page).to have_content post.content
        expect(page).to have_content user.nickname
      end
  end

  describe "ログ一覧機能の検証" do
    before do
      visit posts_path
    end
    it '1件目のPostの詳細が表示される' do
      expect(page).to have_content post.title
      expect(page).to have_content post.content
      expect(page).to have_content user.nickname
    end
    it '2件目のPostの詳細が表示される' do
      expect(page).to have_content post1.title
      expect(page).to have_content post1.content
      expect(page).to have_content user.nickname
    end
    it '投稿タイトルをクリックすると詳細ページへ遷移すること' do
      click_on post.title
      expect(current_path).to eq post_path(post.id)
    end
  end

  describe "ログ削除機能の検証" do
    context "投稿したユーザーでログインしている場合" do
      before do
        sign_in user
        visit post_path(post.id)
      end
      it '削除ボタンが表示される' do
        expect(page).to have_button '削除'
      end
      it '投稿を削除できること' do
        click_on '削除'
        expect(current_path).to eq posts_path
        expect(page).to have_content '投稿が削除されました'
        expect(page).to_not have_link post_path(post.id)
      end
    end

    context "投稿したユーザーでログインしていない場合" do
      before do
        visit post_path(post.id)
      end
      it '削除ボタンが表示されない' do
        expect(page).to_not have_button '削除'
      end
    end
  end
end
