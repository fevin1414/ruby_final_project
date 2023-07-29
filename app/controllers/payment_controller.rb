class PaymentController < ApplicationController

  def create
    # Retrieve product data from the session
    @products = session[:products]

    # Construct line_items for Stripe from the product data
    line_items = @products.map do |item|
      {
        name: item[:product].name,
        amount: item[:product].price_cents,
        currency: 'cad',
        quantity: item[:quantity]
      }
    end

    # Set up a Stripe session
    @session = Stripe::Payment::Session.create(
      payment_method_types: ['card'],
      line_items: line_items,
      success_url: payment_success_url,
      cancel_url: payment_cancel_url
    )
  end

  def sucess

  end

  def cancel

  end
end


