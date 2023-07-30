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
      {
        product_id: cart_item.product.id,
        name: cart_item.product.name,
        price: cart_item.product.price || 0,
        quantity: cart_item.quantity
      }
    end

    @gst = 0
@pst = 0
@hst = 0
if params[:address_id].present?
  @address = Address.find(params[:address_id])
  @province = Province.find(@address.province_id)
  @gst = @province.gst.present? ? (@total * @province.gst.to_f / 100) : 0
  @pst = @province.pst.present? ? (@total * @province.pst.to_f / 100) : 0
  @hst = @province.hst.present? ? (@total * @province.hst.to_f / 100) : 0
end
    @total_with_taxes = @total + @gst + @pst + @hst
    session[:products] = @products
    session[:total_with_taxes] = @total_with_taxes
    puts "In CheckoutController - Products: #{session[:products]}, Total with taxes: #{session[:total_with_taxes]}"
  end


  def stripe_payment
    # Use the invoice method to calculate the total price and create the invoice
    invoice


    total_with_taxes = (params[:total_with_taxes].to_f * 100).to_i # Convert total to cents for Stripe

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'cad',
          product_data: {
            name: "Order Total", # or any suitable name
          },
          unit_amount: total_with_taxes,
        },
        quantity: 1
      }],
      mode: 'payment',
      success_url: payment_success_url,
      cancel_url: payment_cancel_url
    )

    # Store the session URL in the session and redirect to the Stripe Checkout page
    session[:stripe_checkout_session_url] = @session.url
    redirect_to payment_redirect_path
  end


  def stripe_redirect
    @checkout_session_url = session[:stripe_checkout_session_url]
    render template: 'payment/redirect_action'
  end
end
