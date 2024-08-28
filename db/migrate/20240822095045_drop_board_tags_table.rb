class DropBoardTagsTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :board_tags
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
