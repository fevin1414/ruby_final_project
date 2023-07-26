class CartsController < ApplicationController
  before_action :set_cart
  before_action :set_user

  def show
    @products = Product.find(@cart.items.keys)
    @addresses = Address.all

  end

  def add_item
    @cart.add_item(params[:product_id], params[:quantity])
    flash[:notice] = 'Item added to cart successfully!'
    redirect_to cart_path
  end

  def remove_item
    @cart.remove_item(params[:product_id])
    flash[:notice] = 'Item removed from cart successfully!'
    redirect_to cart_path
  end

  def update_item
    @cart.update_item(params[:product_id], params[:quantity])
    flash[:notice] = 'Cart updated successfully!'
    redirect_to cart_path
  end

  def total
    @items.sum { |product_id, quantity| Product.find(product_id).price * quantity.to_d }
  end

  private

  def set_cart
    @cart = Cart.new(session)
  end
  def set_user
    @user = current_user || User.new
  end

end
