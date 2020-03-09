class Product < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :substitutions
  has_many :quantities
  has_many :shopping_lists, through: :quantities
  has_many :availabilities
  has_many :stores, through: :availabilities
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true
  validates :ingredients, presence: true
  validates :price_range, presence: true, inclusion: { in: ['£', '££', '£££'] }
  validates :low_cal, inclusion: { in: [true, false] }
  validates :high_protein, inclusion: { in: [true, false] }
  validates :gluten_free, inclusion: { in: [true, false] }
  validates :calories_per_100g, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :carbs_per_100g, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :protein_per_100g, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :fat_per_100g, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :water_saved, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :energy_saved, presence: true, numericality: { greater_than_or_equal_to: 0 }
  has_many_attached :images
end
