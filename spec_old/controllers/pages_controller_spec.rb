require 'spec_helper'

describe PagesController do
  include_context "pages support"
  describe "GET index" do
    it "assigns to @page the root home page when no person is specified" do 
      get :index
      assigns(:page).should eq(@home)
      response.should render_template("index")
    end
  end
  describe "GET show" do
    it "assigns to @page the expected root page when no person is specified" do 
      get :show, :path => 'about-us'
      assigns(:page).should eq(@about_us)
      response.should render_template("show")
    end
    it "raises an error when a page is specified that does not exist at the root" do 
      expect {get :show, :path => 'personal-page'}.to raise_error
    end
  end
  describe "GET index (person/nickname/pages)" do
    it "assigns to @page the person's home page when a person is specified" do  
      get :index, :person_id => 'page_owner'
      assigns(:page).should eq(@personal_home)
      response.should render_template("index")
    end
  end
  describe "GET show (person/nickname/pages/id)" do
    it "assigns to @page the person's expected page when a person is specified" do 
      get :show, :person_id => 'page_owner', :path => 'personal-page'
      assigns(:page).should eq(@personal_page)
      response.should render_template("show")
    end
  end
  describe "GET new (person/nickname/pages/new)" do
    it "builds a new record" do
      sign_in :user, @page_owner 
      get :new
      assigns(:page).new_record?.should be true
      response.should render_template("new")
    end
  end
  describe "GET edit (person/nickname/pages/id/edit)" do
    it "builds an edit page" do
      sign_in :user, @page_owner 
      get :edit, :id => 7, :person_id => 'page_owner'
      assigns(:page).should eq(@personal_page)
      response.should render_template("edit")
    end
  end
  describe "POST create (person/nickname/pages)" do
    context "with valid attributes" do
      it "creates a new page" do
        sign_in :user, @page_owner 
        page = {:title => 'Count This Page', :body => 'body'}
        
        expect {post :create, :page => page}.to change(Page, :count).by(1)
      end

      it "posts a new page" do
        sign_in :user, @page_owner 
        page = {:title => 'Title With Spaces', :body => 'body'}
        post :create, :page => page
        response.should redirect_to('/people/page_owner/pages/title-with-spaces')
      end
    end
    context "with invalid attributes" do
      it "does not save the new page" do
        sign_in :user, @page_owner 
        page = {}
        expect {post :create, :page => page}.to_not change(Page,:count)
      end
      
      it "re-renders the new method" do
        sign_in :user, @page_owner 
        page = {}
        post :create, :page => page
        response.should render_template :new
      end
    end
  end
  describe "PUT update (person/nickname/pages/id)" do
    context "with valid attributes" do
      it "locates the requested page" do
        sign_in :user, @page_owner
        put :update, :id => @personal_page.id, :page => FactoryGirl.attributes_for(:page)
        assigns(:page).should eq(@personal_page)  
      end
      it "changes @page's attributes" do
        sign_in :user, @page_owner
        put :update, :id => @personal_page.id, :page => FactoryGirl.attributes_for(:page, :title => "Personal", :body => "Page")
        @personal_page.reload
        @personal_page.title.should eq("Personal")
        @personal_page.body.should eq("Page")
      end
      it "redirects to the updated page" do
        sign_in :user, @page_owner
        put :update, :id => @personal_page.id, :page => FactoryGirl.attributes_for(:page)
        response.should redirect_to @personal_page.path
      end
    end
    context "with invalid attributes" do
      it "locates the requested page" do
        sign_in :user, @page_owner
        put :update, :id => @personal_page.id, :page => FactoryGirl.attributes_for(:page, :title => '', :body => '')
        assigns(:page).should eq(@personal_page)  
      end
      it "does not change @page's attributes" do
        sign_in :user, @page_owner
        put :update, :id => @personal_page.id, :page => FactoryGirl.attributes_for(:page, :title => '', :body => '')
        @personal_page.reload
        @personal_page.title.should_not eq('')
        @personal_page.body.should_not eq('')
      end
      it "re-renders the edit method" do
        sign_in :user, @page_owner
        put :update, :id => @personal_page.id, :page => FactoryGirl.attributes_for(:page, :title => '', :body => '')
        response.should render_template :edit
      end
    end
  end
  describe "DELETE delete (person/nickname/pages/id)" do
    it "deletes the page" do
      sign_in :user, @page_owner
      expect{
        delete :destroy, :id => @personal_page.id       
      }.to change(Page,:count).by(-1)
    end
      
    it "redirects to pages#index" do        
      sign_in :user, @page_owner
      delete :destroy, :id => @personal_page.id
      response.should redirect_to '/people/page_owner/pages'
    end
  end
end