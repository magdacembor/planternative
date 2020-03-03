class ShoppingList < ApplicationRecord
  belongs_to :user
  has_many :quantities
end
