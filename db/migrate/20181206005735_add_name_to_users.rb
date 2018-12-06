class AddNameToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :name, :string
    change_column :users, :name, :string, null: false
    add_index :users, :name, unique: true
  end

  def down
    remove_column :users, :name
  end
end
