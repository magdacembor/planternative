class Store < ApplicationRecord
  has_many :availabilities
  has_many :products, through: :availabilities

  validates :name, :address, :latitude, :longitude, presence: true
end
