class User < ApplicationRecord
  has_many :periods
  has_many :operations
  has_many :sessions, class_name: 'UserSession', dependent: :delete_all

  validates :email, presence: true

  has_secure_password
end
