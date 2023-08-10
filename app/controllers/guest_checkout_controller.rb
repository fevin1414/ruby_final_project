class GuestCheckoutController < ApplicationController
  def new_address
    @provinces = Province.all
  end

  def create_address
    @provinces = Province.all
    @cart_items = session[:cart] || []

    # Retrieve the address data directly from the form
    address_data = params[:address]

    # Build a new Address instance using the form data
    @address = Address.new(address_params.merge(address_data))

    if @address.save
      session[:province_id] = @address.province_id
      render 'invoice_g'
    else
      flash.now[:alert] = "Address could not be saved."
      puts @address.errors.full_messages
      render 'new_address'
    end
  end

  def invoice
    @cart_items = session[:cart] || []
    @total = @cart_items.sum { |id, quantity| Product.find(id).price.to_f * quantity.to_f }

    @province = Province.find(session[:province_id])
    @pst = (@total * @province.pst) / 100
    @gst = (@total * @province.gst) / 100
    @hst = (@total * @province.hst) / 100
    @tax = @pst + @gst + @hst
    @final_total = @total + @tax

    # Retrieve the stored guest address data from the session
    guest_address_data = session[:guest_address] || {}
    @address = Address.new(guest_address_data)

    render 'invoice_g'
  end

  private

  def address_params
    params.require(:address).permit(:street, :city, :province_id)
  end
end
