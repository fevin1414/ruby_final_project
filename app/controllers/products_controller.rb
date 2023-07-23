class ProductsController < ApplicationController
  def index
    @products = Product.all

    if params[:keyword].present?
      @products = @products.where("products.name LIKE ? OR products.description LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end

    if params[:category].present?
      @products = @products.joins(:category).where(categories: { id: params[:category] })
    end

    if params[:on_sale].present?
      @products = @products.on_sale
    end

    if params[:newly_added].present?
      @products = @products.newly_added
    end

    if params[:recently_updated].present?
      @products = @products.recently_updated
    end

    @products = @products.page(params[:page]).per(5)
  end

  def show
    @product = Product.find(params[:id])
  end

  # You can add other actions as needed, such as new, create, etc.
end
