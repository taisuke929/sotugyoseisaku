class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, uniqueness: true
  enum rank: { silver: 0, gold: 1, master: 3 }
  enum lane: {top: 0, jg: 1, mid: 2, adc: 3, sup: 4 }
  validates :name, presence: true
  validates :reset_password_token, uniqueness: true, allow_nil: true

  has_many :boards, dependent: :destroy

  def own?(object)
    id == object&.user_id
  end

  class << self
    def find_or_create_from_auth_hash(auth_hash)
      user_params = {
        email: auth_hash.info.email,
        name: auth_hash.info.name,
        image: auth_hash.info.image
      }

      find_or_create_by(email: user_params[:email]) do |user|
        user.update(user_params)
      end
    end
  end
end
