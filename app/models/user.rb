class User < ApplicationRecord
  has_secure_password

  has_many :books
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
end
