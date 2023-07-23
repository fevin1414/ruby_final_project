class CategoriesController < ApplicationController
  def show
    @category = Category.find_by(id: params[:id])
    if @category
      @products = @category.products.page(params[:page]).per(10)
    else
      redirect_to root_path, alert: "Category not found"
    end
  end

  # You can add other actions as needed, such as index, new, create, etc.
end
