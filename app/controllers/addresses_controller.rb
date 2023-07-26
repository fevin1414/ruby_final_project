class AddressesController < ApplicationController
  before_action :set_address, only: %i[show edit update destroy]
  def show
    @address = Address.find(params[:id])
  end

  def index
    @addresses = Address.where(user_id: current_user.id)
  end

  def new
    @address = Address.new
  end
  def edit
    @address = current_user.addresses.find(params[:id])
  end
  def create
    @address = Address.new(address_params)
    @address.user_id = current_user.id

    if @address.save
      redirect_to @address, notice: 'Address was successfully created.'
    else
      render :new
    end
  end

  def update
    if @address.update(address_params)
      redirect_to @address, notice: 'Address was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @address.destroy
    redirect_to addresses_path, notice: 'Address was successfully destroyed.'
  end

  private

  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:street, :city, :province_id)
  end
end
