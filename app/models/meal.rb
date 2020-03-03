class Meal < ApplicationRecord
  has_many :substitutions
  validates :name, presence: true, uniqueness: true
end
