require 'spec_helper'

describe PagesController do
  routes { Cooperative::Engine.routes }

  describe 'routing' do
    it { should route(:get, '/pages/parent').to(:action => 'show', :path => 'parent') }
    it { should route(:get, '/pages/parent/child').to(:action => 'show', :path => 'parent/child') }

    for nicknamed_nesting_resource in %w{people}
      it { should route(:get, "/#{nicknamed_nesting_resource}/nickname/pages/foo").to(:action => 'show', "#{nicknamed_nesting_resource.singularize}_id".to_sym => 'nickname', :path => 'foo') }
      it { should route(:get, "/#{nicknamed_nesting_resource}/nickname/pages/new").to(:action => 'new', "#{nicknamed_nesting_resource.singularize}_id".to_sym => 'nickname') }
      it { should route(:post, "/#{nicknamed_nesting_resource}/nickname/pages").to(:action => 'create', "#{nicknamed_nesting_resource.singularize}_id".to_sym => 'nickname') }
      it { should route(:get, "/#{nicknamed_nesting_resource}/nickname/pages/1/edit").to(:action => 'edit', "#{nicknamed_nesting_resource.singularize}_id".to_sym => 'nickname', :id => 1) }
      it { should route(:put, "/#{nicknamed_nesting_resource}/nickname/pages/1").to(:action => 'update', "#{nicknamed_nesting_resource.singularize}_id".to_sym => 'nickname', :id => 1) }
      it { should route(:delete, "/#{nicknamed_nesting_resource}/nickname/pages/1").to(:action => 'destroy', "#{nicknamed_nesting_resource.singularize}_id".to_sym => 'nickname', :id => 1) }
    end
  end

  describe 'at the root' do
    include_context 'pages support'
    describe 'GET show' do
      before do
        get :show, :path => root_parent_page.test_path
      end
      it { should respond_with(:success) }
      it { should render_template(:show) }
      it { should_not set_the_flash }
    end
  end

  describe 'within a person' do
    include_context 'pages support'
    describe 'GET show' do
      context 'when the page is public' do
        before do
          get :show, :nesting_resource => 'people', :id => page_owner.nickname, :path => owned_parent_page.test_path
        end
        it { should respond_with(:success) }
        it { should render_template(:show) }
        it { should_not set_the_flash }
      end
      context 'when the page is limited access' do
        context 'when not logged in' do
          before do
            get :show, :nesting_resource => 'people', :id => private_page_owner.nickname, :path => private_home_page.test_path
          end
          it { should respond_with(:redirect) }
          it { should set_the_flash }
        end
        context 'when logged in but not authorized' do
          before do
            sign_in page_stranger
            get :show, :nesting_resource => 'people', :id => private_page_owner.nickname, :path => private_home_page.test_path
          end
          it { should respond_with(403) }
          it { should_not set_the_flash }
        end
        context 'when authorized' do
          before do
            sign_in page_viewer
            get :show, :nesting_resource => 'people', :id => private_page_owner.nickname, :path => private_home_page.test_path
          end
          it { should respond_with(:success) }
          it { should render_template(:show) }
          it { should_not set_the_flash }
        end
      end
    end
    describe 'GET new' do
      include_context 'pages support'
      context 'when not logged in' do
        before do
          get :new, :nesting_resource => 'people', :person_id => page_owner.nickname
        end
        it { should respond_with(:redirect) }
        it { should set_the_flash }
      end
      context 'when logged in' do
        before do
          sign_in page_owner
          get :new, :nesting_resource => 'people', :person_id => page_owner.nickname
        end
        it { should respond_with(:success) }
        it { should render_template(:new) }
        it { should_not set_the_flash }
      end
    end
    describe 'POST create' do

      include_context 'groups support'
      context 'when not logged in' do
        before do
          post :create, :nesting_resource => 'people', :person_id => page_owner.nickname
        end
        it { should respond_with(:redirect) }
        it { should set_the_flash }
      end
      context 'when logged in' do
        context 'with invalid attributes' do
          before do
            sign_in page_owner
            post :create, :nesting_resource => 'people', :person_id => page_owner.nickname
          end
          it { should respond_with(:success) }
          it { should render_template(:new) }
          it { should_not set_the_flash }
        end
        context 'with valid attributes' do
          before do
            sign_in page_owner
            post :create, :page => {:title => 'Page', :body => 'Body'}, :nesting_resource => 'people', :person_id => page_owner.nickname
          end
          it { should respond_with(:redirect) }
          it { should set_the_flash }
        end
      end
    end
    describe 'GET edit' do
      include_context 'pages support'
      context 'when not logged in' do
        before do
          get :edit, :id => owned_parent_page.id, :nesting_resource => 'people', :person_id => page_owner.nickname
        end
        it { should respond_with(:redirect) }
        it { should set_the_flash }
      end
      context 'when logged in, but not as the owner' do
        before do
          sign_in page_stranger
          get :edit, :id => owned_parent_page.id, :nesting_resource => 'people', :person_id => page_owner.nickname
        end
        it { should respond_with(403) }
        it { should_not set_the_flash }
      end
      context 'when logged in as owner' do
        before do
          sign_in page_owner
          get :edit, :id => owned_parent_page.id, :nesting_resource => 'people', :person_id => page_owner.nickname
        end
        it { should respond_with(:success) }
        it { should render_template(:edit) }
        it { should_not set_the_flash }
      end
      context 'when bogus commentable_id given' do
        before do
          sign_in page_owner
          get :edit, :id => 10000, :nesting_resource => 'people', :person_id => page_owner.nickname
        end
        it { should respond_with(404) }
        it { should_not set_the_flash }
      end
    end
    describe 'PUT update' do
      include_context 'pages support'
      context 'when not logged in' do
        before do
          put :update, :id => owned_parent_page.id, :page => {:title => 'Page', :body => 'Body'}, :nesting_resource => 'people', :person_id => page_owner.nickname
        end
        it { should respond_with(:redirect) }
        it { should set_the_flash }
      end
      context 'when logged in, but not as the owner' do
        before do
          sign_in page_stranger
          put :update, :id => owned_parent_page.id, :page => {:title => 'Page', :body => 'Body'}, :nesting_resource => 'people', :person_id => page_owner.nickname
        end
        it { should respond_with(403) }
        it { should_not set_the_flash }
      end
      context 'when logged in as owner' do
        context 'with invalid attributes' do
          before do
            sign_in page_owner
            put :update, :id => owned_parent_page.id, :page => {:title => '', :body => ''}, :nesting_resource => 'people', :person_id => page_owner.nickname
          end
          it { should respond_with(:success) }
          it { should render_template(:edit) }
          it { should_not set_the_flash }
        end
        context 'with valid attributes' do
          before do
            sign_in page_owner
            put :update, :id => owned_parent_page.id, :page => {:title => 'Page', :body => 'Body'}, :nesting_resource => 'people', :person_id => page_owner.nickname
          end
          it { should respond_with(:redirect) }
          it { should set_the_flash }
        end
      end
      context 'when bogus commentable_id given' do
        before do
          sign_in page_owner
          put :update, :id => 10000, :page => {:title => 'Page', :body => 'Body'}, :nesting_resource => 'people', :person_id => page_owner.nickname
        end
        it { should respond_with(404) }
        it { should_not set_the_flash }
      end
    end
    describe 'DELETE destroy' do
      include_context 'pages support'
      context 'when not logged in' do
        before do
          delete :destroy, :id => owned_parent_page.id, :nesting_resource => 'people', :person_id => page_owner.nickname
        end
        it { should respond_with(:redirect) }
        it { should set_the_flash }
      end
      context 'when logged in, but not as the owner' do
        before do
          sign_in page_stranger
          delete :destroy, :id => owned_parent_page.id, :nesting_resource => 'people', :person_id => page_owner.nickname
        end
        it { should respond_with(403) }
        it { should_not set_the_flash }
      end
      context 'when logged in as owner' do
        before do
          sign_in page_owner
          delete :destroy, :id => owned_parent_page.id, :nesting_resource => 'people', :person_id => page_owner.nickname
        end
        it { should respond_with(:redirect) }
      end
      context 'when bogus commentable_id given' do
        before do
          sign_in page_owner
          delete :destroy, :id => 10000, :nesting_resource => 'people', :person_id => page_owner.nickname
        end
        it { should respond_with(404) }
        it { should_not set_the_flash }
      end
    end
  end

end