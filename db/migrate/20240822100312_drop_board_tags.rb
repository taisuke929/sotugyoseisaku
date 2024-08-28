class DropBoardTags < ActiveRecord::Migration[6.1]
  def up
    drop_table :board_tags
  rescue ActiveRecord::StatementInvalid => e
    puts "Table does not exist or has already been dropped."
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
