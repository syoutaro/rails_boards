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

class Board < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 1000 }
end
