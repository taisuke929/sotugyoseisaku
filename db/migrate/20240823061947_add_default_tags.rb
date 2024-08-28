class AddDefaultTags < ActiveRecord::Migration[6.1]
  def up
    Tag.create(name: 'rank')
    Tag.create(name: '1vs1')
    Tag.create(name: 'normal')
  end

  def down
    Tag.where(name: ['rank', '1vs1', 'normal']).delete_all
  end
end
