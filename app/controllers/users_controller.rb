class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    # Add custom logic for user index page here
  end
end