require 'spec_helper'

describe TagsController do
  include_context "tags support"
  describe "GET index" do
    it "assigns to @tags the tags found in the db" do 
      get :index
      assigns(:tags).should eq Tag.all
      response.should render_template("index")
    end
  end
  describe "GET show" do
    it "assigns to @tag the expected tag" do 
      get :show, :id => 'foo'
      assigns(:tag).should eq(@foo)
      response.should render_template("show")
    end
    it "raises an error when a group is specified that does not exist" do 
      expect {get :show, :id => 'puppy'}.to raise_error
    end
  end
end