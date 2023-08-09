class ProductsController < ApplicationController
  include Breadcrumbable

  def index
    @products = Product.all

    if params[:keyword].present?
      @products = @products.where("products.name LIKE ? OR products.description LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end

    if params[:category].present?
      @products = @products.joins(:category).where(categories: { id: params[:category] })
    end

    case params[:filter]
    when 'on_sale'
      @products = @products.on_sale
    when 'newly_added'
      @products = @products.newly_added
    when 'recently_updated'
      @products = @products.recently_updated
    end

    @products = @products.page(params[:page]).per(5)
  end


  def show
    @product = Product.find(params[:id])

  end
  def create
    @product = Product.new(product_params)

    # Set the newly added product as "on sale"
    @product.on_sale = true

    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end
  # You can add other actions as needed, such as new, create, etc.
end
