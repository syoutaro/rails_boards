# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord
  has_many :board_tag_relations, dependent: :delete_all
  has_many :boards, through: :board_tag_relations, dependent: :delete_all

  validates :name,
    presence: true,
    length: { maximum: 30 },
    uniqueness: { case_sensitive: false }
end
