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

class Board < ApplicationRecord
  belongs_to :owner, class_name: User, foreign_key: :user_id
  has_many :comments, dependent: :delete_all
  has_many :board_tag_relations, dependent: :delete_all
  has_many :tags, through: :board_tag_relations, dependent: :delete_all
  mount_uploader :image, ImageUploader
  counter_culture :owner

  validates :title,
    presence: true,
    length: { maximum: 30 },
    uniqueness: { scope: :user_id }

  validates :body,
    presence: true,
    length: { maximum: 1000 }
end
