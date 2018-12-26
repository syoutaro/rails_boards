class AddBoardsCountToUsers < ActiveRecord::Migration[5.1]
  def self.up
    add_column :users, :boards_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :users, :boards_count
  end
end
