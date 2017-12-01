class Store < ApplicationRecord
  belongs_to :user
  validates :name, :user, presence: true
  validates_uniqueness_of :name, :scoope => :user_id
end
