

class CartsController < ApplicationController
  include Breadcrumbable
  before_action :set_cart
  before_action :set_user
  before_action :set_product, only: [:show, :add_item]  # Updated

  def show
    product_ids = @cart.items.keys
    @products = Product.where(id: product_ids)
    @addresses = Address.all
  end

  def add_item
    @cart.add_item(params[:product_id], params[:quantity])
    flash[:notice] = 'Item added to cart successfully!'
    redirect_to cart_path(product_id: @product.id)  # Updated
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
    if !current_user && session[:cache_cleared]
      @cart.clear_items
      session[:cache_cleared] = false
    end
  end


  def set_user
    @user = current_user || User.new
  end

  def set_product
    @product = Product.find(params[:product_id]) if params[:product_id].present?
  end
end
