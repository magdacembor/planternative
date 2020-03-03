class Substitution < ApplicationRecord
  belongs_to :meal
  belongs_to :product
  validates :name, presence: true, uniqueness: true
end
