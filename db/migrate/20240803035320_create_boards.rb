class CreateBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :boards do |t|
      t.integer :user_id, null: false
      t.column :rank, :integer
      t.column :lane, :integer
      t.string :purpose

      t.timestamps
    end

    add_index :boards, :user_id
  end
end
