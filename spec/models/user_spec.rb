require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  it "名前、メールアドレス、パスワードがあれば有効な状態であること" do
    expect(user.nickname).to eq('サンジ')
    expect(user.email).to eq(user.email)
  end

  it "名前、メールアドレス、パスワードがあれば有効な状態であること" do
    expect(user).to be_valid
  end

  it "名前がなければ無効な状態であること" do
    user.nickname = nil
    user.valid?
    expect(user.errors[:nickname]).to include("が入力されていません。")
  end

  it "メールアドレスがなければ無効な状態であること" do
    user.email = nil
    user.valid?
    expect(user.errors[:email]).to include("が入力されていません。")
  end

  it "パスワードがなければ無効な状態であること" do
    user.password = nil
    user.valid?
    expect(user.errors[:password]).to include("が入力されていません。")
  end

  describe '文字数制限の検証' do
    context 'nicknameが20文字以下の場合' do
      it 'User オブジェクトは有効である' do
        expect(user.valid?).to be(true)
      end
    end

    context 'nicknameが20文字を超える場合' do
      it 'User オブジェクトは無効である' do
        user.nickname = "あいうえおかきくけこさしすせそたちつてとな"
        user.valid?

        expect(user.valid?).to be(false)
        expect(user.errors[:nickname]).to include('は20文字以下に設定して下さい。')
      end
    end
  end
end
