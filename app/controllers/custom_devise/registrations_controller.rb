class CustomDevise::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def create
    puts "Sign Up Params: #{sign_up_params}"
    build_resource(sign_up_params)
    resource.name = params[:user][:name]
    puts "Resource: #{resource.inspect}"
    if resource.persisted?
      sign_up(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
end
