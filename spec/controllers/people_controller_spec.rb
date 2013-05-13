require 'spec_helper'

describe PeopleController do
  include_context "people support"
  describe "GET index" do
    it "gets the public @people and renders the index template" do 
      get :index
      assigns(:people).should eq(@public_users)
      response.should render_template("index")
    end
  end
  describe "GET show" do
    it "gets the requested @person and renders the show template" do 
      get :show, :id => @public_users.first.nickname
      assigns(:person).should eq(@public_users.first)
      response.should render_template("show")
    end
    it "raises an error when a person is specified who does not exist" do 
      expect {get :show, :id => 999999}.to raise_error
    end
  end
end