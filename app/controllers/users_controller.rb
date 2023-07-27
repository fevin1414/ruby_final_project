class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end
  def dashboard
    # Add any necessary logic here
  end
end