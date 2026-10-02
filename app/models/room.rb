class Room < ApplicationRecord
  belongs_to :user
  has_many :reservatons
  has_one_attached :image
end
