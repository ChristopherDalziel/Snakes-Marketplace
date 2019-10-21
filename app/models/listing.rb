class Listing < ApplicationRecord
  belongs_to :breed
  has_many :listings_traits
  has_many :traits, through: :listings_traits
  
  enum sex: { female: 0, male: 1}

  validates :title, :sex, :price, :breed, presence: true

  validates :description, presence: true, 
              length: { minimum: 10 }

  validates :price, numericality: true

  validates :state, inclusion: { in: %w(VIC NSW WA TAS NT ACT QLD SA), :message => "%{value} is not a valid state" }

  # validates :deposit, numericality: { only_integer: true, less_than: @listing.price }
 
  # validates_numericality_of :deposit, :greater_than_or_equal_to 

  validates_numericality_of :deposit, :only_integer => true, :less_than_or_equal_to => :price

  has_one_attached :picture

end
 