class CartsController < ApplicationController
  include Breadcrumbable
  before_action :set_cart
  before_action :set_user
  before_action :set_product, only: [:show, :add_item]  # Updated

  def show
    if user_signed_in?
      @shopping_cart = current_user.shopping_cart
      @cart_items = @shopping_cart.cart_items.includes(:product)
      @total = @shopping_cart.total_price
      # Save products in session
      session[:cart_products] = @cart_items.map { |item| { id: item.product_id, quantity: item.quantity } }
    else
      @cart_items = @cart.items.keys.map { |product_id| OpenStruct.new(product: Product.find(product_id), quantity: @cart.items[product_id]) }
      @total = @cart.total
      # Save products in session
      session[:cart_products] = @cart_items.map { |item| { id: item.product.id, quantity: item.quantity } }
    end
    session[:cart_total] = @total
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
    @cart = Cart.new(session, current_user)
    if !current_user && session[:clear_cart_on_logout]
      @cart.clear_items
      session[:clear_cart_on_logout] = false
    end
  end



  def set_user
    @user = current_user || User.new
  end

  def set_product
    @product = Product.find(params[:product_id]) if params[:product_id].present?
  end
end
