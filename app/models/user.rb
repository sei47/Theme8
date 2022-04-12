class User < ApplicationRecord
  mount_uploader :profile_image, ImageUploader
  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  before_validation { email.downcase! }
  has_secure_password
  has_many :pictures
end
