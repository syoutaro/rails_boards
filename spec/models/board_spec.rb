# == Schema Information
#
# Table name: boards
#
#  id             :bigint(8)        not null, primary key
#  body           :text(65535)      not null
#  comments_count :integer          default(0), not null
#  image          :string(255)
#  title          :string(255)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint(8)        not null
#
# Indexes
#
#  index_boards_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Board, type: :model do
  it "タイトルがなければ無効の状態であること" do
    board = FactoryBot.build(:board, title: nil)
    board.valid?
    expect(board.errors[:title]).to include("が入力されていません。")
  end

  it "タイトルが30文字以下でなければ無効の状態であること" do
    board = FactoryBot.build(:board, title: "a" * 31)
    board.valid?
    expect(board.errors[:title]).to include("は30文字以下に設定して下さい。")
  end

  it "ユーザー単位では重複したタイトルを許可しないこと" do
    user = FactoryBot.create(:user)
    user.boards.create(title: "テスト",body: "本文")
    new_board = user.boards.build(title: "テスト",body: "本文")
    new_board.valid?
    expect(new_board.errors[:title]).to include("は既に使用されています。")
  end

  it "二人のユーザーが同じタイトルを使うことは許可すること" do
    FactoryBot.create(:board, title: "テスト")
    new_board = FactoryBot.build(:board, title: "テスト")
    new_board.valid?
    expect(new_board).to be_valid
  end

  it "本文がなければ無効の状態であること" do
    board = FactoryBot.build(:board, body: nil)
    board.valid?
    expect(board.errors[:body]).to include("が入力されていません。")
  end

  it "本文が1000文字以下でなければ無効の状態であること" do
    board = FactoryBot.build(:board, body: "a" * 1001)
    board.valid?
    expect(board.errors[:body]).to include("は1000文字以下に設定して下さい。")
  end

end
