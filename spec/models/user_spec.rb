# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  avatar                 :string(255)
#  boards_count           :integer          default(0), not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  name                   :string(255)      not null
#  point                  :integer          default(5), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
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

  it "ユーザーネームが無ければ無効の状態であること" do
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

  it "ポイントが無ければ向こうの状態であること" do
    user = FactoryBot.build(:user, point: nil)
    user.valid?
    expect(user.errors[:point]).to include("が入力されていません。")
  end

  it "ポイントが整数でなければならない" do
    user = FactoryBot.build(:user, point: 0.5)
    user.valid?
    expect(user.errors[:point]).to include("は整数で入力してください")
  end

  it "ポイントが0以上でなければ無効になる" do
    user = FactoryBot.build(:user, point: -1)
    user.valid?
    expect(user.errors[:point]).to include("は0以上の値にしてください")
  end
end
