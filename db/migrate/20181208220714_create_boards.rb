class CreateBoards < ActiveRecord::Migration[5.1]
  def change
    create_table :boards do |t|
      t.references :user, foreign_key: true, null: false
      t.string :title,    null: false
      t.text :body,       null: false

      t.timestamps
    end
  end
end
