class User < ApplicationRecord
  authenticates_with_sorcery!
  has_secure_password validations: false

  validates :password, length: { minimum: 3 }, if: -> { (new_record? || changes[:crypted_password]) && uid.blank? }
  validates :password_confirmation, presence: true, if: -> { (new_record? || changes[:crypted_password]) && uid.blank? }
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
        uid: auth_hash.uid, 
        provider: auth_hash.provider 
      }

      find_or_create_by(email: user_params[:email]) do |user|
        user.update(user_params)
        Rails.logger.info("User update errors: #{user.errors.full_messages}") unless user.errors.empty?
      end
    end
  end
end
