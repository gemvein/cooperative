require 'spec_helper'

describe FollowsController do
  include_context "people support"
  describe "POST create (person/nickname/follows)" do
    context "with valid attributes" do
      it "follows the named person" do
        sign_in :user, @login_user
        post :create, :person_id => @hidden_users.first.nickname, :format => :js
        @login_user.reload
        @login_user.following?(@hidden_users.first).should be true
      end

      it "redirects to the person's page" do
        sign_in :user, @login_user
        post :create, :person_id => @hidden_users.first.nickname, :format => :js
        response.should render_template 'create'
      end
    end
  end
  describe "DELETE delete (person/nickname/follows)" do
    it "deletes the follow" do
      sign_in :user, @login_user
      @login_user.follows(@hidden_users.first)
      delete :destroy, :person_id => @hidden_users.first.nickname, :format => :js
      @login_user.following?(@hidden_users.first).should be false
    end
      
    it "redirects to pages#index" do
      sign_in :user, @login_user
      @login_user.follows(@hidden_users.first)
      delete :destroy, :person_id => @hidden_users.first.nickname, :format => :js
      response.should render_template 'destroy'
    end
  end
end