require 'spec_helper'

describe ApplicationController do
  controller do
    def unauthorized_page
      raise CanCan::AccessDenied
    end
  end

  describe "handling AccessDenied exceptions" do
    it "redirects to the home page and flashes a notice" do
      get :unauthorized_page
      response.should redirect_to(home_path)
      flash[:alert].should_not be_nil
    end
  end
end