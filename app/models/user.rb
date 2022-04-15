class User < ApplicationRecord
  mount_uploader :profile_image, ImageUploader
  validates :name, presence: true
  validates :email, presence: true

  before_validation { email.downcase! }
  has_secure_password
  has_many :pictures
  has_many :favorites, dependent: :destroy
  has_many :favorite_pictures, through: :favorites, source: :picture
end
