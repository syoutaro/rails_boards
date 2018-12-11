# == Schema Information
#
# Table name: board_tag_relations
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :integer          not null
#  tag_id     :integer          not null
#
# Indexes
#
#  index_board_tag_relations_on_board_id  (board_id)
#  index_board_tag_relations_on_tag_id    (tag_id)
#

require 'rails_helper'

RSpec.describe BoardTagRelation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
