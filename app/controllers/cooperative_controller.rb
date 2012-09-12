class CooperativeController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  
  add_breadcrumb 'Home', '/'
  def set_locale
    I18n.local = params[:lang] if params[:lang].present?
  end
end
