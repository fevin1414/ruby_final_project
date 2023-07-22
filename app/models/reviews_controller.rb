class ReviewsController < ApplicationController


  private

  def review_params
    params.require(:review).permit(:customer_name, :rating, :content, :product_id, images: [])
  end
end