class Painting < ApplicationRecord
  belongs_to :user
  validates :picture,  presence: true
  validates :description,  presence: true
  validates :price, numericality: { greater_than_or_equal_to: 10000}
  mount_uploader :picture, PictureUploader
  acts_as_taggable # Alias for acts_as_taggable_on :tags
end
