require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }
  let!(:post) { create(:post) }

  describe "GET /new" do
    context "ログインしていない場合" do
      it "ログインページにリダイレクトされる" do
        get new_post_path
        expect(response).to redirect_to '/users/sign_in'
      end
      it 'HTTPステータス302を返す' do
        get new_post_path
        expect(response).to have_http_status(302)
      end
    end

    context "ログインしている場合" do
      before { sign_in user }
      it "ログインページにリダイレクトされない" do
        get "/posts/new"
        expect(response).to_not redirect_to '/users/sign_in'
      end
      it 'HTTPステータス200を返す' do
        get new_post_path
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET /posts/:id' do
    context 'ログインしていない場合' do
      it 'HTTPステータス200を返す' do
        get post_path(post.id)
        expect(response).to have_http_status '200'
      end
    end
    context 'ログインしている場合' do
      it 'HTTPステータス200を返す' do
        sign_in user
        get post_path(post.id)
        expect(response).to have_http_status '200'
      end
    end
  end

  describe 'GET /posts' do
    context 'ログインしていない場合' do
      it 'HTTPステータス200を返す' do
        get posts_path
        expect(response).to have_http_status '200'
      end
    end
    context 'ログインしている場合' do
      it 'HTTPステータス200を返す' do
        sign_in user
        get posts_path
        expect(response).to have_http_status '200'
      end
    end
  end
end
