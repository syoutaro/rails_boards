class AddCommentsCountToBoards < ActiveRecord::Migration[5.1]
  def self.up
    add_column :boards, :comments_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :boards, :comments_count
  end
end
