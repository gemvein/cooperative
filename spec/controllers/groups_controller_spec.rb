require 'spec_helper'

describe GroupsController do
  include_context "groups support"
  describe "GET index" do
    it "assigns to @groups the groups found in the db" do 
      sign_in :user, @group_owner
      get :index
      assigns(:groups).should eq(@public_groups)
      response.should render_template("index")
    end
  end
  describe "GET show" do
    it "assigns to @group the expected group" do 
      sign_in :user, @group_owner
      get :show, :id => 1
      assigns(:group).should eq(@public_groups.first)
      response.should render_template("show")
    end
    it "raises an error when a group is specified that does not exist" do 
      sign_in :user, @group_owner
      expect {get :show, :id => 10000}.to raise_error
    end
  end
  describe "GET new" do
    it "builds a new record" do
      sign_in :user, @group_owner 
      get :new
      assigns(:group).new_record?.should be true
      response.should render_template("new")
    end
  end
  describe "GET edit" do
    it "builds an edit page" do
      sign_in :user, @group_owner 
      get :edit, :id => 1
      assigns(:group).should eq(@public_groups.first)
      response.should render_template("edit")
    end
  end
  describe "POST create" do
    context "with valid attributes" do
      it "creates a new group" do
        sign_in :user, @group_owner 
        group = {:name => 'Make this Group'}
        
        expect {post :create, :group => group}.to change(Group, :count).by(1)
      end

      it "redirects to the group" do
        sign_in :user, @group_owner 
        group = {:name => 'Make this Group'}
        post :create, :group => group
        response.should redirect_to('/groups/5')
      end
    end
    context "with invalid attributes" do
      it "does not save the new page" do
        sign_in :user, @group_owner 
        group = {}
        expect {post :create, :group => group}.to_not change(Group,:count)
      end
      
      it "re-renders the new method" do
        sign_in :user, @group_owner 
        group = {}
        post :create, :group => group
        response.should render_template :new
      end
    end
  end
  describe "PUT update" do
    context "with valid attributes" do
      it "locates the requested page" do
        sign_in :user, @group_owner 
        put :update, :id => @public_groups.first.id, :group => FactoryGirl.attributes_for(:group)
        assigns(:group).should eq(@public_groups.first)  
      end
      it "changes @group's attributes" do
        sign_in :user, @group_owner 
        put :update, :id => @public_groups.first.id, :group => FactoryGirl.attributes_for(:group, :name => "Changes", :description => "Boo")
        @public_groups.first.reload
        @public_groups.first.name.should eq("Changes")
        @public_groups.first.description.should eq("Boo")
      end
      it "redirects to the updated page" do
        sign_in :user, @group_owner 
        put :update, :id => @public_groups.first.id, :group => FactoryGirl.attributes_for(:group)
        response.should redirect_to '/groups/' + @public_groups.first.id.to_s
      end
    end
    context "with invalid attributes" do
      it "locates the requested group" do
        sign_in :user, @group_owner 
        put :update, :id => @public_groups.first.id, :group => FactoryGirl.attributes_for(:group, :name => '')
        assigns(:group).should eq(@public_groups.first)  
      end
      it "does not change @group's attributes" do
        sign_in :user, @group_owner 
        put :update, :id => @public_groups.first.id, :group => FactoryGirl.attributes_for(:group, :name => '')
        @public_groups.first.reload
        @public_groups.first.name.should_not eq('')
      end
      it "re-renders the edit method" do
        sign_in :user, @group_owner 
        put :update, :id => @public_groups.first.id, :group => FactoryGirl.attributes_for(:group, :name => '')
        response.should render_template :edit
      end
    end
  end
  describe "DELETE delete" do
    it "deletes the group" do
      sign_in :user, @group_owner
      expect{
        delete :destroy, :id => @public_groups.first.id       
      }.to change(Group,:count).by(-1)
    end
      
    it "redirects to pages#index" do        
      sign_in :user, @group_owner
      delete :destroy, :id => @public_groups.first.id
      response.should redirect_to '/groups'
    end
  end
end