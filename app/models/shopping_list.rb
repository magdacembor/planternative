class ShoppingList < ApplicationRecord
  belongs_to :user
  has_many :quantities, dependent: :destroy
  has_many :products, through: :quantities
end
