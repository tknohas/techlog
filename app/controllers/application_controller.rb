class ApplicationController < ActionController::Base
  before_action :configure_permitted_patameters, if: :devise_controller?

  protected

  def configure_permitted_patameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end
