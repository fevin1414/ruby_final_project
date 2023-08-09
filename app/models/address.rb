class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province
  has_many :orders

  validates :street, presence: true
  validates :city, presence: true
  validates :province_id, :user_id, presence: true, numericality: { only_integer: true }
end
