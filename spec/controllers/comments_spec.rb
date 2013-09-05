require 'spec_helper'

describe CommentsController do
  routes { Cooperative::Engine.routes }

  describe 'routing' do
    it { should route(:post, '/comments').to(:action => 'create') }
    it { should route(:get, '/comments/1').to(:action => 'show', :id => 1) }
    it { should route(:delete, '/comments/1').to(:action => 'destroy', :id => 1) }

    for nesting_resource in %w{statuses}
      it { should route(:get, "/#{nesting_resource}/1/comments").to(:action => 'index', "#{nesting_resource.singularize}_id".to_sym => 1) }
    end
  end

  describe 'GET index' do
    include_context 'comments support'
    context 'when not logged in' do
      before do
        get :index, :nesting_resource => 'statuses', :status_id => owned_status.id
      end
      it { should respond_with(:redirect) }
      it { should set_the_flash }
    end
    context 'when logged in' do
      before do
        sign_in follower_user
        get :index, :nesting_resource => 'statuses', :status_id => owned_status.id
      end
      it { should respond_with(:success) }
      it { should render_template(:index) }
      it { should_not set_the_flash }
    end
  end

  describe 'GET show' do
    include_context 'comments support'
    context 'when not logged in' do
      before do
        get :show, :id => followed_comment.id
      end
      it { should respond_with(:redirect) }
      it { should set_the_flash }
    end
    context 'when logged in as owner' do
      before do
        sign_in follower_user
        get :show, :id => owned_comment.id
      end
      it { should respond_with(:success) }
      it { should render_template(:show) }
      it { should_not set_the_flash }
    end
    context 'when logged in as follower' do
      before do
        sign_in follower_user
        get :show, :id => followed_comment.id
      end
      it { should respond_with(:success) }
      it { should render_template(:show) }
      it { should_not set_the_flash }
    end
    context 'when logged in as unauthorized' do
      before do
        sign_in follower_user
        get :show, :id => unfollowed_comment.id
      end
      it { should respond_with(404) }
      it { should_not set_the_flash }
    end
    context 'when bogus id given' do
      before do
        sign_in follower_user
        get :show, :id => 10000
      end
      it { should respond_with(404) }
      it { should_not set_the_flash }
    end
  end

  describe 'POST create' do
    include_context 'comments support'
    context 'when not logged in' do
      before do
        post :create, :comment => {:commentable_id => owned_status.id, :commentable_type => 'Status'}, :format => :js
      end
      it { should respond_with(401) }
      it { should_not set_the_flash }
    end
    context 'when logged in as owner' do
      before do
        sign_in follower_user
        post :create, :comment => {:commentable_id => owned_status.id, :commentable_type => 'Status'}, :format => :js
      end
      it { should respond_with(:success) }
      it { should render_template(:create) }
      it { should_not set_the_flash }
    end
    context 'when logged in as follower' do
      before do
        sign_in follower_user
        post :create, :comment => {:commentable_id => followed_status.id, :commentable_type => 'Status'}, :format => :js
      end
      it { should respond_with(:success) }
      it { should render_template(:create) }
      it { should_not set_the_flash }
    end
    context 'when logged in as unauthorized' do
      before do
        sign_in follower_user
        post :create, :comment => {:commentable_id => unfollowed_status.id, :commentable_type => 'Status'}, :format => :js
      end
      it { should respond_with(404) }
      it { should_not set_the_flash }
    end
    context 'when bogus commentable_id given' do
      before do
        sign_in follower_user
        post :create, :comment => {:commentable_id => 10000, :commentable_type => 'Status'}, :format => :js
      end
      it { should respond_with(404) }
      it { should_not set_the_flash }
    end
  end

  describe 'DELETE destroy' do
    include_context 'comments support'
    context 'when not logged in' do
      before do
        delete(:destroy, :id => owned_comment.id, :format => :js)
      end
      it { should respond_with(401) }
      it { should_not set_the_flash }
    end
    context 'when logged in as owner' do
      before do
        sign_in follower_user
        delete(:destroy, :id => owned_comment.id, :format => :js)
      end
      it { should respond_with(:success) }
      it { should render_template(:destroy) }
      it { should_not set_the_flash }
    end
    context 'when logged in as commentable owner' do
      before do
        sign_in follower_user
        delete(:destroy, :id => followed_comment.id, :format => :js)
      end
      it { should respond_with(:success) }
      it { should render_template(:destroy) }
      it { should_not set_the_flash }
    end
    context 'when logged in as unauthorized' do
      before do
        sign_in follower_user
        delete(:destroy, :id => unfollowed_comment.id, :format => :js)
      end
      it { should respond_with(404) }
      it { should_not set_the_flash }
    end
    context 'when bogus commentable_id given' do
      before do
        sign_in follower_user
        delete(:destroy, :id => 10000, :format => :js)
      end
      it { should respond_with(404) }
      it { should_not set_the_flash }
    end
  end
end