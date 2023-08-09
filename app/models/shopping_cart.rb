class ShoppingCart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  # Assuming there's a total_price field in the shopping cart
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # Add validations for any other necessary attributes
end
