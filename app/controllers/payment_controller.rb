class PaymentController < ApplicationController
  def redirect_action
    # Retrieve the Stripe Checkout session URL from the session
    @checkout_session_url = session[:stripe_checkout_session_url]
    session.delete(:stripe_checkout_session_url)
  end

  def success
    # Handle the success callback here
  end

  def cancel
    # Handle the cancel callback here
  end
end
