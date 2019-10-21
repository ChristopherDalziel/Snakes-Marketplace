class Trait < ApplicationRecord
  has_many :listings_traits
  has_many :listings, through: :listings_traits
end
