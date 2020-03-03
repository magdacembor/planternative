class Quantity < ApplicationRecord
  belongs_to :product
  belongs_to :shopping_list

  validates :quantity, presence: true, numericality: { only_integer: true}
  validates :quantity, numericality: { greater_than: 0 }
end
