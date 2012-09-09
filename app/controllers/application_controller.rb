class ApplicationController < CooperativeController
  protect_from_forgery
  before_filter :set_locale
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to cooperative.home_url, :alert => exception.message
  end
end