# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "タグがなければ無効の状態であること" do
    tag = Tag.new(name: nil)
    tag.valid?
    expect(tag.errors[:name]).to include("が入力されていません。")
  end

  it "タグが30文字以下であること" do
    tag = Tag.new(name: "a" * 31)
    tag.valid?
    expect(tag.errors[:name]).to include("は30文字以下に設定して下さい。")
  end

  it "タグの名前が重複するのを許可しないこと" do
    Tag.create!(name: "テスト１")
    tag = Tag.new(name: "テスト１")
    tag.valid?
    expect(tag.errors[:name]).to include("は既に使用されています。")
  end
end
