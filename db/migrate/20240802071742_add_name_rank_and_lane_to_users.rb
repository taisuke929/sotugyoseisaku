class AddNameRankAndLaneToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :rank, :integer
    add_column :users, :lane, :integer
  end
end
