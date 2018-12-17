# == Schema Information
#
# Table name: boards
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_boards_on_user_id  (user_id)
#

FactoryBot.define do
  factory :board do
    sequence(:title) { |n| "タイトル#{n}" }
    body "テストです。"
    association :owner
  end
end
