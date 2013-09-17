require 'spec_helper'

describe StatusesController, 'routing' do
  routes { Cooperative::Engine.routes }
  it { should route(:get, '/statuses/new').to(:action => 'new') }
  it { should route(:post, '/statuses').to(:action => 'create') }
  it { should route(:get, '/statuses/1').to(:action => 'show', :id => 1) }
  it { should route(:delete, '/statuses/1').to(:action => 'destroy', :id => 1) }
  it { should route(:get, '/statuses/grab').to(:action => 'grab') }
  
  describe 'GET show' do
    include_context 'statuses support'
    context 'when the status is public' do
      before do
        get :show, :id => public_status.id
      end
      it { should respond_with(:success) }
      it { should render_template(:show) }
      it { should_not set_the_flash }
    end
    context 'when the status is limited access' do
      context 'when not logged in' do
        before do
          get :show, :id => unshared_status.id
        end
        it { should respond_with(:redirect) }
        it { should set_the_flash }
      end
      context 'when logged in but not authorized' do
        before do
          sign_in unfollowed_user
          get :show, :id => unshared_status.id
        end
        it { should respond_with(403) }
        it { should_not set_the_flash }
      end
      context 'when authorized' do
        before do
          sign_in follower_user
          get :show, :id => unshared_status.id
        end
        it { should respond_with(:success) }
        it { should render_template(:show) }
        it { should_not set_the_flash }
      end
    end
  end
  describe 'GET new' do
    include_context 'statuses support'
    context 'when not logged in' do
      before do
        get :new
      end
      it { should respond_with(:redirect) }
      it { should set_the_flash }
    end
    context 'when logged in' do
      before do
        sign_in followed_user
        get :new
      end
      it { should respond_with(:success) }
      it { should render_template(:new) }
      it { should_not set_the_flash }
    end
  end
  describe 'POST create' do
    include_context 'statuses support'
    context 'when not logged in' do
      before do
        post :create, :format => 'js'
      end
      it { should respond_with(401) }
      it { should_not set_the_flash }
    end
    context 'when logged in' do
      context 'with invalid attributes' do
        before do
          sign_in followed_user
          post :create, :format => 'js'
        end
        it { should respond_with(:success) }
        it { should render_template(:create) }
        it { should_not set_the_flash }
      end
      context 'with valid attributes' do
        before do
          sign_in followed_user
          post :create, :status => {:body => 'Body'}, :format => 'js'
        end
        it { should respond_with(:success) }
        it { should render_template(:create) }
        it { should_not set_the_flash }
      end
    end
  end
  describe 'DELETE destroy' do
    include_context 'statuses support'
    context 'when not logged in' do
      before do
        delete :destroy, :id => unshared_status.id, :format => 'js'
      end
      it { should respond_with(401) }
      it { should_not set_the_flash }
    end
    context 'when logged in, but not as the owner' do
      before do
        sign_in unfollowed_user
        delete :destroy, :id => unshared_status.id, :format => 'js'
      end
      it { should respond_with(403) }
      it { should_not set_the_flash }
    end
    context 'when logged in as owner' do
      before do
        sign_in followed_user
        delete :destroy, :id => unshared_status.id, :format => 'js'
      end
      it { should respond_with(:success) }
      it { should render_template(:destroy) }
      it { should_not set_the_flash }
    end
    context 'when bogus commentable_id given' do
      before do
        sign_in followed_user
        delete :destroy, :id => 10000, :format => 'js'
      end
      it { should respond_with(404) }
      it { should_not set_the_flash }
    end
  end

  describe 'GET grab' do
    include_context 'follower support'
    context 'when not logged in' do
      before do
        get :grab, :uri => 'http://www.queenoftarot.com/', :format => 'js'
      end
      it { should respond_with(401) }
      it { should_not set_the_flash }
    end
    context 'when logged in' do
      before do
        sign_in followed_user
        get :grab, :uri => 'http://www.queenoftarot.com/', :format => 'js'
      end
      it { should respond_with(:success) }
      it { should render_template(:grab) }
      it { should_not set_the_flash }
    end
  end
end