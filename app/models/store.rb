class Store < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_many :availabilities
  has_many :products, through: :availabilities

  validates :name, :address, presence: true
end
