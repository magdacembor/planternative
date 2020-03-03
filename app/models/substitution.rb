class Substitution < ApplicationRecord
  belongs_to :meal
  belongs_to :product
  validates :name, presence: true
  validates :meal, :product, presence: true
  validates :name, uniqueness: { scope: :meal }
end
