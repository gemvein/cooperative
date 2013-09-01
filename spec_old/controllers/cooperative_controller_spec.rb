require 'spec_helper'

describe CooperativeController do
  controller do
    def index
      redirect_to '/'
    end
  end

  describe "handling errors" do
    it "can handle a 404 error at the root" do
      pending "can't figure out how to test it"
    end
    it "can handle a 401 error" do
      pending "can't figure out how to test it"
    end
  end

  describe "handling locale" do
    it "sets the appropriate locale" do
      get :index, :use_route => :cooperative, :locale => 'en'
      I18n.locale.should == :en
    end
  end
end