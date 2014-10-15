class User < ActiveRecord::Base
	has_many :posts
	has_many :comments
  has_many :votes

  has_secure_password validations: false
  validates :name, presence: true, length: {minimum: 3}, uniqueness: :true
  validates :password, presence: true, on: :create, length: {minimum: 8}
end