class Meal < ApplicationRecord
  has_many :substitutions
  has_many :products, through: :substitutions
  validates :name, presence: true, uniqueness: true
   include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [ :name ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
  has_one_attached :photo
end
