class Board < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :board_tags, dependent: :destroy
  has_many :tags, through: :board_tags
  
  enum rank: { silver: 0, gold: 1, master: 3 }
  enum lane: {top: 0, jg: 1, mid: 2, adc: 3, sup: 4 }

  validates :rank, presence: true
  validates :lane, presence: true
  validates :purpose, presence: true, length: { maximum: 1000 }
  validates :title, presence: true
  
end
