class Substitution < ApplicationRecord
  belongs_to :meal
  belongs_to :product
  validates :meal, :product, presence: true
  include PgSearch::Model
  pg_search_scope :global_search,
  against: [ :name ],
  associated_against: {
    meal: [ :name ],
    product: [ :name, :ingredients ]
  },
  using: {
    tsearch: { prefix: true, any_word: true },
    #trigram: { word_similarity: true }
    }
end
