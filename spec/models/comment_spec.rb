# == Schema Information
#
# Table name: comments
#
#  id         :bigint(8)        not null, primary key
#  comment    :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :bigint(8)        not null
#  user_id    :bigint(8)        not null
#
# Indexes
#
#  index_comments_on_board_id  (board_id)
#  index_comments_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (board_id => boards.id)
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "コメントが無ければ無効の状態であること" do
    comment = FactoryBot.build(:comment, comment: nil)
    comment.valid?
    expect(comment.errors[:comment]).to include("が入力されていません。")
  end

  it "コメントが1000文字以下でなければ無効の状態であること" do
    comment = FactoryBot.build(:comment, comment: "a" * 1001)
    comment.valid?
    expect(comment.errors[:comment]).to include("は1000文字以下に設定して下さい。")
  end
end
