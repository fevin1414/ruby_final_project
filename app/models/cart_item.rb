class CartItem < ApplicationRecord
  belongs_to :shopping_cart
  belongs_to :product

  validates :shopping_cart_id, presence: true
  validates :product_id, presence: true
end
