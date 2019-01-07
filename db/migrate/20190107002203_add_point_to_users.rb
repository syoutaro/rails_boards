class AddPointToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :point, :integer, null: false, default: 5
  end
end
