require 'rails_helper'

RSpec.describe 'Homes', type: :system do
  before do
    driven_by(:rack_test)
  end

  it "topページにアクセスできること" do
    visit "/"
    expect(page).to have_content('Home#top')
  end

  describe 'ナビゲーションバーの検証' do
    context 'ログインしていない場合' do
      before { visit '/' }

      it 'ユーザー登録リンクを表示する' do
        expect(page).to have_link('登録', href: '/users/sign_up')
      end

      it 'ログインリンクを表示する' do
        expect(page).to have_link('ログイン', href: '/users/sign_in')
      end

      it 'ログ投稿リンクを表示しない' do
        expect(page).to_not have_link('ログ投稿', href: '/posts/new')
      end

      it 'ログアウトリンクは表示しない' do
        expect(page).not_to have_content('ログアウト')
      end
    end

    context 'ログインしている場合' do
      let(:user) { create(:user) } # ログイン用のユーザーを作成
      before do
        sign_in user # 作成したユーザーでログイン
        visit '/'
      end

      it 'ユーザー登録リンクは表示しない' do
        expect(page).not_to have_link('登録', href: '/users/sign_up')
      end

      it 'ログインリンクは表示しない' do
        expect(page).not_to have_link('ログイン', href: '/users/sign_in')
      end

      it 'ログアウトリンクを表示する' do
        expect(page).to have_content('ログアウト')
      end
      it 'ログ投稿リンクを表示する' do
        expect(page).to have_link('ログ投稿', href: '/posts/new')
      end

      it 'ログアウトリンクが機能する' do
        click_on 'ログアウト'

        # ログインしていない状態のリンク表示パターンになることを確認
        expect(page).to have_link('登録', href: '/users/sign_up')
        expect(page).to have_link('ログイン', href: '/users/sign_in')
        expect(page).not_to have_link('ログアウト')
      end
    end
  end
end
