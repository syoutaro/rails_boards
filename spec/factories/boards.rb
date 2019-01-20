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

FactoryBot.define do
  factory :board , aliases: [:content] do
    sequence(:title) { |n| "タイトル#{n}" }
    body "テストです。"
    image File.open(File.join(Rails.root, "db/picture/image/image1.jpg"))
    association :owner
  end
end
