class ApplicationController < CooperativeController
  protect_from_forgery
  before_filter :set_locale
  rescue_from CanCan::AccessDenied, :with => :access_denied
end