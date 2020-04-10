class User < ApplicationRecord
  has_secure_password

  has_many :books
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true, length: { minimum: 5, maximum: 20 }
  validates :password, presence: true, length: { minimum: 5, maximum: 15 }
end
