class ApplicationController < ActionController::Base
  def choose_root_path
    if user_signed_in?
      if current_user.admin?
        redirect_to admin_root_path
      else
        redirect_to users_root_path
      end
    else
      redirect_to products_path
    end
  end


  private

  # After signing in, redirect to the appropriate path based on the user's role
  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_root_path
    else
      user_dashboard_path
    end
  end
end