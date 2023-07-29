class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @addresses = @user.addresses
    @total = (session[:cart_total] || "0").to_f

    if params[:address_id].present?
      @address = Address.find(params[:address_id])
      @province = Province.find(@address.province_id)
      @gst = @province.gst.present? ? (@total * @province.gst.to_f / 100) : 0
      @pst = @province.pst.present? ? (@total * @province.pst.to_f / 100) : 0
      @hst = @province.hst.present? ? (@total * @province.hst.to_f / 100) : 0
    end
  end

  def create
    @user = current_user
    selected_address_id = params[:address_id]
    # ... add your logic here ...
    flash[:notice] = 'Here is your total amount'
    redirect_to index_checkout_path(address_id: selected_address_id)
  end

  def invoice
    @user = current_user
    @addresses = @user.addresses
    @total = @user.shopping_cart.total_price || 0

    # Fetch products from the cart_items table
    @products = @user.shopping_cart.cart_items.includes(:product).map do |cart_item|
      { product: cart_item.product, quantity: cart_item.quantity }
    end

    if params[:address_id].present?
      @address = Address.find(params[:address_id])
      @province = Province.find(@address.province_id)
      @gst = @province.gst.present? ? (@total * @province.gst.to_f / 100) : 0
      @pst = @province.pst.present? ? (@total * @province.pst.to_f / 100) : 0
      @hst = @province.hst.present? ? (@total * @province.hst.to_f / 100) : 0
    end
    session[:products] = @products
  end


end
