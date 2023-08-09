# app/models/cart_item.rb
class CartItem < ApplicationRecord
  belongs_to :shopping_cart
  belongs_to :product

  # Assuming you have quantity or other attributes that need to be validated
  validates :shopping_cart_id, :product_id, presence: true, numericality: { only_integer: true }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
