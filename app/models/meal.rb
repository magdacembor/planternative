class Meal < ApplicationRecord
  has_many :substitutions
  has_many :products, through: :substitutions
  validates :name, presence: true, uniqueness: true
end
