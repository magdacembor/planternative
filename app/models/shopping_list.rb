class ShoppingList < ApplicationRecord
  belongs_to :user
  has_many :quantities
  has_many :products, through: :quantities
end
