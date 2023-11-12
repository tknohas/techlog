require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { build(:user) }
  before do
    driven_by(:rack_test)
    visit new_user_registration_path
  end

  describe "新規登録" do
    context "成功する場合" do
      before do
        fill_in "user_email", with: user.email
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
          expect(page).to have_content"3 errors prohibited this user from being saved:"
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
          expect(page).to have_content"Nickname is too long (maximum is 20 characters)"
        end
      end
    end
  end
end
