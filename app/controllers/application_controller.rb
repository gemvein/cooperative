class ApplicationController < CooperativeController
  protect_from_forgery
  before_filter :set_locale
end