class CartsController < ApplicationController
  before_action :set_cart

  def show
    @products = Product.find(@cart.items.keys)
  end

  def add_item
    @cart.add_item(params[:product_id], params[:quantity])
    redirect_to cart_path
  end

  def remove_item
    @cart.remove_item(params[:product_id])
    redirect_to cart_path
  end

  def update_item
    @cart.update_item(params[:product_id], params[:quantity])
    redirect_to cart_path
  end

  def total
    @items.sum { |product_id, quantity| Product.find(product_id).price * quantity.to_d }
  end


  private

  def set_cart
    @cart = Cart.new(session)
  end
end