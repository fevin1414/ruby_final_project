class AddShoppingCartReferenceToCartItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :cart_items, :shopping_cart, foreign_key: true
  end
end
