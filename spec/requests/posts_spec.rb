require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }

  describe "GET /new" do
    context "ログインしていない場合" do
      it "ログインページにリダイレクトされる" do
        get "/posts/new"
        expect(response).to redirect_to '/users/sign_in'
      end
    end

    context "ログインしている場合" do
      before { sign_in user }
      it "ログインページにリダイレクトされない" do
        get "/posts/new"
        expect(response).to_not redirect_to '/users/sign_in'
      end
      it 'HTTPステータス200を返す' do
        get '/posts/new'
        expect(response).to have_http_status(200)
      end
    end
  end
end
