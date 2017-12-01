class Seller < ApplicationRecord
  belongs_to :store
  validates :name, :store, presence: true
  validates_length_of :name, maximum: 50
end
