class CheckoutController < ApplicationController
  before_action :ensure_cart_is_not_empty, only: [:getcheckout, :invoice]
  before_action :set_address, only: [:update_address]

  def getcheckout
    if session[:province_id].blank?
      flash[:alert] = "Province information is missing!"
      redirect_to checkout_address_path # Redirect to the appropriate path
      return
    end
    @province_id = params[:province_id] || (user_signed_in? ? current_user.province_id : nil)

    unless @province_id
      flash[:alert] = "Province information is missing!"
      redirect_to checkout_address_path # Redirect to the appropriate path
      return
    end

    puts "Province ID: #{@province_id}"
    # Find the province of the user or use the one provided in params


    if session[:province_id].blank?
      flash[:alert] = "Province information is missing!"
      redirect_to checkout_address_path # Redirect to the appropriate path
      return
    end
    # Calculate the total price of the cart
    @total = @cart.sum { |item| Product.find(item['id']).price * item['quantity'].to_i }

    # Get tax details of the province
    @province = Province.find(@province_id)
    @pst = (@total * @province.pst) / 100
    @gst = (@total * @province.gst) / 100
    @hst = (@total * @province.hst) / 100
    @tax = @pst + @gst + @hst
    @final_total = @total + @tax


    session[:total] = @total
    session[:province_id] = @province_id
    session[:pst] = @pst
    session[:gst] = @gst
    session[:hst] = @hst
    session[:tax] = @tax

    redirect_to checkout_path
  end

  def invoice
    if session[:province_id].blank?
      flash[:alert] = "Province information is missing!"
      redirect_to checkout_address_path # Redirect to the appropriate path
      return
    end
    if user_signed_in?
      @address = Address.find_by(user_id: current_user.id)
    end
    # Get the cart items
    @cart_items = session[:cart] || []
    puts "session[:cart]: #{session[:cart].inspect}"

    # Calculate the total, tax, and other details
    @total = @cart_items.sum do |id, quantity|
      product = Product.find(id)
      product.price * quantity.to_i
    end

    @province = Province.find(session[:province_id])
    @pst = (@total * @province.pst) / 100
    @gst = (@total * @province.gst) / 100
    @hst = (@total * @province.hst) / 100
    @tax = @pst + @gst + @hst

    @cart = @cart_items.map do |id, quantity|
      puts "item id: #{id}, quantity: #{quantity}"
      product = Product.find(id)
      { product: product, quantity: quantity.to_i, price: product.price * quantity.to_i }
    end

  end

  def pay_now
    ActiveRecord::Base.transaction do
      user = current_user

      address = Address.find_by(user_id: user.id)

      total = params[:total].to_f
      tax = params[:tax].to_f

      order = Order.create!(total: total + tax, user: user, address: address, status: "new")

      customer_name = user.name || "Default Customer Name"
      customer = Customer.create!(
        name: customer_name,
        email: user.email,
        user_id: user.id,
        order_id: order.id,
        subtotal: total,
        gst: params[:gst],
        pst: params[:pst],
        hst: params[:hst],
        total_with_taxes: total + tax,
        product_data: params[:cart]
      )

      cart_items = JSON.parse(params[:cart])
      cart_items.each do |item_data|
        product = Product.find(item_data["product"]["id"])
        OrderItem.create!(order: order, product: product, quantity: item_data["quantity"].to_i)
      end
    end

    # Redirect to a success page or whatever you want to do next
  rescue => e
    flash[:alert] = "An error occurred while processing the order: #{e.message}"
    redirect_to checkout_path
  end


  def address
    if user_signed_in?
      @address = Address.find_by(user_id: current_user.id) || Address.new
    else
      # Handle the case for users who are not signed in
    end
  end

  def create_address
    @address = Address.new(address_params)
    if @address.save
      session[:province_id] = @address.province_id # Set the province_id in the session
      flash[:notice] = 'Address saved successfully!'
      redirect_to checkout_invoice_path # or wherever you want to redirect
    else
      flash[:alert] = 'Unable to save address!'
      render :address
    end
  end

  def update_address
    if @address.update(address_params)
      session[:province_id] = @address.province_id # Set the province_id in the session
      flash[:notice] = 'Address updated successfully!'
      redirect_to checkout_invoice_path# or wherever you want to redirect
    else
      flash[:alert] = 'Unable to update address!'
      render :address
    end
  end

  private

  def ensure_cart_is_not_empty
    @cart = session[:cart] || []
    redirect_to cart_path if @cart.empty?
  end
  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:street, :city, :province_id, :user_id)
  end
end
