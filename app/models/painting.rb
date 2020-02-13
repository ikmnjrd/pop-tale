class Painting < ApplicationRecord
  belongs_to :user
  validates :picture,  presence: true
  validates :description,  presence: true
  mount_uploader :picture, PictureUploader
end
