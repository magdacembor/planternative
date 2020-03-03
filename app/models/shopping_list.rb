class ShoppingList < ApplicationRecord
  belongs_to :user
  has_many :quantities

  validates: :mark_as_done, inclusion: { in: [true, false] }
  validates: :date, presence: true
end
