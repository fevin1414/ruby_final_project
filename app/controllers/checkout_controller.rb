# app/controllers/checkout_controller.rb
class CheckoutController < ApplicationController
  before_action :authenticate_user! # Ensure user is logged in to access checkout

  def index
    @user = current_user
    @addresses = @user.addresses
  end

  def create
    @user = current_user
    # Logic for processing the checkout, you can add this as needed.
    # For example, create an order and associate it with the selected address.
    selected_address_id = params[:address_id]
    # ... add your logic here ...
    flash[:notice] = 'Here is your total amount '
    redirect_to checkout_path
  end
end
