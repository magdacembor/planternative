class Product < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :substitutions
  has_many :quantities
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true
  validates :ingredients, presence: true, uniqueness: true
  validates :price_range, presence: true, inclusion: { in: ['£', '££', '£££'] }
  validates :low_cal, presence: true, inclusion: { in: [true, false] }
  validates :high_protein, presence: true, inclusion: { in: [true, false] }
  validates :gluten_free, presence: true, inclusion: { in: [true, false] }
  validates :calories_per_100g, presence: true, numericality: { only_integer: true }
  validates :carbs_per_100g, presence: true, numericality: { greater_than: 0 }
  validates :protein_per_100g, presence: true, numericality: { greater_than: 0 }
  validates :fat_per_100g, presence: true, numericality: { greater_than: 0 }
  validates :water_saved, presence: true, numericality: { greater_than: 0 }
  validates :energy_saved, presence: true, numericality: { greater_than: 0 }
  has_many_attached :photos
end
