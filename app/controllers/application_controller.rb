class ApplicationController < CooperativeController
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery
  before_filter :set_locale

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit :nickname, :email, :password, :password_confirmation
    end
  end
end