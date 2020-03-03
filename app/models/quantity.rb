class Quantity < ApplicationRecord
  belongs_to :product
  belongs_to :shopping_list
end
