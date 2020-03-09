class Recipe < ApplicationRecord
  belongs_to :product
  validates :name, presence: true
  validates :url, presence: true
  validates :image_url, presence: true
end
