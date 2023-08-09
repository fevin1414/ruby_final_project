class CheckoutController < ApplicationController
  before_action :set_user

  def show
    @address = @user.addresses.first # Assuming the user may have one or more addresses
    @order = @user.orders.new # Create a new order object for the user
    @products = fetch_products_from_cart # Method to get the products in the cart

    calculate_totals
  end
  def create
    # Assuming you are receiving the address_id as a parameter
    address_id = params[:address_id]

    # Fetching the address based on the given ID
    @selected_address = Address.find_by(id: address_id)

    if @selected_address
      # Additional logic for processing the order goes here
    else
      flash[:error] = "Address not found"
      redirect_to checkout_path # Redirecting back to the checkout page if the address is not found
    end
  end
  private

  def set_user
    @user = User.find(current_user.id) # Assuming you have a method to get the current logged-in user
  end



  def calculate_totals
    @total = @products.sum { |product| product.price * product.quantity }
    province = @address ? @address.province : Province.first # Default province for tax calculations, if needed
    @gst = @total * province.gst
    @pst = @total * province.pst
    @hst = @total * province.hst
    @total_with_taxes = @total + @gst + @pst + @hst
  end
end
