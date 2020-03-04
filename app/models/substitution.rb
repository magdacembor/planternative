class Substitution < ApplicationRecord
  belongs_to :meal
  belongs_to :product
  # validates :name, presence: true
  validates :meal, :product, presence: true
  validates :name, uniqueness: { scope: :meal }
  include PgSearch::Model
  pg_search_scope :global_search,
  against: [ :name ],
  associated_against: {
    meal: [ :name ],
    product: [ :name ]
  },
  using: {
    tsearch: { prefix: true }
  }
end
