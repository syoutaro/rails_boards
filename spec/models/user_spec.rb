# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_name                  (name) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do

  it "メールアドレス、パスワード、確認用パスワード、ユーザーネームが入力されていれば有効である" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "ユーザーネームがなければ無効の状態であること" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("が入力されていません。")
  end

  it "ユーザーネームが30文字以下でなければ無効の状態であること" do
    user = FactoryBot.build(:user, name: "a" * 31)
    user.valid?
    expect(user.errors[:name]).to include("は30文字以下に設定して下さい。")
  end

  it "ユーザーネームが重複するのを許可しないこと" do
    FactoryBot.create(:user, name: "test1")
    user = FactoryBot.build(:user, name: "test1")
    user.valid?
    expect(user.errors[:name]).to include("は既に使用されています。")
  end
end
