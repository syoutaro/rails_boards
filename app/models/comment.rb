# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  comment    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_comments_on_board_id  (board_id)
#  index_comments_on_user_id   (user_id)
#

class Comment < ApplicationRecord
  belongs_to :content, class_name: Board, foreign_key: :board_id
  belongs_to :owner, class_name: User, foreign_key: :user_id
  validates :comment, presence: true, length: { maximum: 1000 }
end
