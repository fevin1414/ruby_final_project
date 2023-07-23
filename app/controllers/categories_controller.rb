class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @products = @category.products
  end

  # You can add other actions as needed, such as index, new, create, etc.
end
