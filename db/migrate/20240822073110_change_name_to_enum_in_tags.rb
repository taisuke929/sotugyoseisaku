class ChangeNameToEnumInTags < ActiveRecord::Migration[6.1]
  def up
    remove_column :tags, :name
    add_column :tags, :name, :integer, null: false
  end

  def down
    remove_column :tags, :name
    add_column :tags, :name, :string, null: false
  end
end
