class CreateBoardTagRelations < ActiveRecord::Migration[5.1]
  def change
    create_table :board_tag_relations do |t|
      t.references :board, foreign_key: true, null: false
      t.references :tag,   foreign_key: true, null: false

      t.timestamps
    end
  end
end
