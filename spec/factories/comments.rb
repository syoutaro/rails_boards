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

FactoryBot.define do
  factory :comment do
    comment "テストです。"
    association :content
    association :owner
  end
end
