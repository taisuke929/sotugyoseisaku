class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, uniqueness: true
  enum rank: { silver: 0, gold: 1, master: 3 }
  enum lane: {top: 0, jg: 1, mid: 2, adc: 3, sup: 4 }
  validates :name, presence: true

  has_many :boards, dependent: :destroy

  def own?(object)
    id == object&.user_id
  end
end
