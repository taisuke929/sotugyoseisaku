class Tag < ApplicationRecord
  has_many :board_tags, dependent: :destroy
  has_many :boards, through: :board_tags

  enum name: { rank: 'rank', "1vs1": '1vs1', normal: 'normal' }
end
