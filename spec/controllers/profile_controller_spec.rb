require 'spec_helper'

describe ProfileController do
  include_context "populate people"
  describe "GET edit" do
    it "gets the @login_user and renders the edit template" do 
      sign_in :user, @login_user
      get :edit
      assigns(:user).should eq(@login_user)
      response.should render_template("edit")
    end
  end
  describe "PUT update" do
    it "locates the requested page" do
      sign_in :user, @login_user
      put :update, :id => @login_user.id, :user => FactoryGirl.attributes_for(:user)
      assigns(:user).should eq(@login_user)  
    end
    it "changes @login_user's attributes" do
      sign_in :user, @login_user
      put :update, :id => @login_user.id, :user => FactoryGirl.attributes_for(:user, :bio => "Bio Goes Here")
      @login_user.reload
      @login_user.bio.should eq("Bio Goes Here")
    end
    it "redirects to the updated page" do
      sign_in :user, @login_user
      put :update, :id => @login_user.id, :user => FactoryGirl.attributes_for(:user, :id => @login_user.id, :nickname => @login_user.nickname, :bio => "Bio Goes Here")
      response.should redirect_to '/people/' + @login_user.nickname
    end
  end
end