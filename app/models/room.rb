class Room < ApplicationRecord
  belongs_to :user
  has_many :reservatons
  has_one_attached :image
  
  validates :price, numericality: { greater_than_or_equal_to: 1}
end
