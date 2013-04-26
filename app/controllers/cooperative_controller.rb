class CooperativeController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  rescue_from CanCan::AccessDenied, :with => :access_denied 
  
  add_breadcrumb :home.l, '/'

private
  def set_locale
    I18n.local = params[:lang] if params[:lang].present?
  end
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def access_denied (exception)
    redirect_to cooperative.home_url, :alert => exception.message
  end 
end
