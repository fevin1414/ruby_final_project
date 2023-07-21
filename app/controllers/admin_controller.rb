class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def index
    # Add custom logic for admin index page here
  end

  private

  def require_admin!
    redirect_to root_path unless current_user.admin?
  end
end