require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let(:user) { create(:user) }
  let!(:post) { create(:post) }
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
end
