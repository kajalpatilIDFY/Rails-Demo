class User < ApplicationRecord
  has_secure_password

  has_many :tasks, dependent: :destroy

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email" }
end
