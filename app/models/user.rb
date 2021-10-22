class User < ApplicationRecord
  validates :name, presence: true
  validates :surname, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :passw, presence: true
  
  has_many :paths, dependent: :destroy
end
