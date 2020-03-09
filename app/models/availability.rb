class Availability < ApplicationRecord
  belongs_to :store
  belongs_to :product

  validates :product, :store, presence: true
end
