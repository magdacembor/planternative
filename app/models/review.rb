class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :content, :rating, :user, :product, presence: true
  validates :rating, inclusion: { in: (1..5) }

end
