# app/models/shopping_cart.rb
class ShoppingCart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  # Add any other necessary attributes and validations
end
