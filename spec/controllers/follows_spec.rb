require 'spec_helper'

describe FollowsController, 'routing' do
  routes { Cooperative::Engine.routes }
  describe 'routing' do
    for nicknamed_nesting_resource in %w{people}
      it { should route(:get, "/#{nicknamed_nesting_resource}/nickname/followers").to(:action => 'followers', :id => 'nickname') }
      it { should route(:get, "/#{nicknamed_nesting_resource}/nickname/follows").to(:action => 'index', "#{nicknamed_nesting_resource.singularize}_id".to_sym => 'nickname') }
      it { should route(:post, "/#{nicknamed_nesting_resource}/nickname/follows").to(:action => 'create', "#{nicknamed_nesting_resource.singularize}_id".to_sym => 'nickname') }
      it { should route(:delete, "/#{nicknamed_nesting_resource}/nickname/follows/1").to(:action => 'destroy', "#{nicknamed_nesting_resource.singularize}_id".to_sym => 'nickname', :id => 1) }
    end
  end

  describe 'GET index' do
    include_context 'follower support'
    context 'when not logged in' do
      before do
        get :index, :nesting_resource => 'people', :person_id => followed_user.nickname
      end
      it { should respond_with(:redirect) }
      it { should set_the_flash }
    end
    context 'when logged in' do
      before do
        sign_in follower_user
        get :index, :nesting_resource => 'people', :person_id => followed_user.nickname
      end
      it { should respond_with(:success) }
      it { should render_template(:index) }
      it { should_not set_the_flash }
    end
  end

  describe 'GET followers' do
    include_context 'follower support'
    context 'when not logged in' do
      before do
        get :followers, :nesting_resource => 'people', :id => followed_user.nickname
      end
      it { should respond_with(:redirect) }
      it { should set_the_flash }
    end
    context 'when logged in' do
      before do
        sign_in followed_user
        get :followers, :nesting_resource => 'people', :id => follower_user.nickname
      end
      it { should respond_with(:success) }
      it { should render_template(:followers) }
      it { should_not set_the_flash }
    end
  end

  describe 'POST create' do
    include_context 'follower support'
    context 'when not logged in' do
      before do
        post :create, :nesting_resource => 'people', :person_id => followed_user.nickname, :format => :js
      end
      it { should respond_with(401) }
      it { should_not set_the_flash }
    end
    context 'when logged in' do
      before do
        sign_in follower_user
        post :create, :nesting_resource => 'people', :person_id => followed_user.nickname, :format => :js
      end
      it { should respond_with(:success) }
      it { should render_template(:follow) }
      it { should_not set_the_flash }
    end
  end

  describe 'DELETE destroy' do
    include_context 'follower support'
    context 'when not logged in' do
      before do
        delete :destroy, :nesting_resource => 'people', :person_id => followed_user.nickname, :format => :js
      end
      it { should respond_with(401) }
      it { should_not set_the_flash }
    end
    context 'when logged in' do
      before do
        sign_in follower_user
        delete :destroy, :nesting_resource => 'people', :person_id => followed_user.nickname, :format => :js
      end
      it { should respond_with(:success) }
      it { should render_template(:follow) }
      it { should_not set_the_flash }
    end
  end
end