require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }
  before do
    driven_by(:rack_test)
    visit new_user_registration_path
  end

  describe "新規登録" do
    context "成功する場合" do
      before do
        fill_in "user_email", with: "test2@email"
        fill_in "user_nickname", with: user.nickname
        fill_in "user_password", with: user.password
        fill_in "user_password_confirmation", with: user.password_confirmation
        click_on "ユーザー登録"
      end
      it "登録する" do
        expect(page).to have_content "Welcome! You have signed up successfully."
      end
    end
    context "失敗する" do
      context "項目が空" do
        before do
          fill_in "user_email", with: ""
          fill_in "user_nickname", with: ""
          fill_in "user_password", with: ""
          fill_in "user_password_confirmation", with: ""
          click_on "ユーザー登録"
        end
        it "エラーメッセージが表示される" do
          expect(page).to have_content"が入力されていません。"
        end
      end
      context "文字数" do
        before do
          fill_in "user_email", with: user.email
          fill_in "user_nickname", with: "っっっっっっっっっっっっっっっっっっっっっっっっっっっっっっっっっっっっっっっq"
          fill_in "user_password", with: user.password
          fill_in "user_password_confirmation", with: user.password_confirmation
          click_on "ユーザー登録"
        end
        it "エラーメッセージが表示される" do
          expect(page).to have_content"ニックネームは20文字以下に設定して下さい。"
        end
      end
    end
  end

  describe "ログイン" do
    context "成功する場合" do
      before do
        visit new_user_session_path
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        click_button 'ログイン'
      end

      it "ログインする" do
        expect(page).to have_content "ログインしました"
      end
      it "ログアウトする" do
        click_on "ログアウト"
        expect(page).to have_content "ログアウトしました"
      end
    end
    context "失敗する場合" do
      before do
        visit new_user_session_path
        fill_in 'user_email', with: ""
        fill_in 'user_password', with: ""
        click_button 'ログイン'
      end

      it "ログインできない" do
        expect(page).to have_content "メールアドレスまたはパスワードが違います"
      end
    end
  end
end
