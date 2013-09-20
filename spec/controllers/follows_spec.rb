require 'spec_helper'

describe FollowsController do
  routes { Cooperative::Engine.routes }
  describe 'routing' do
    for nicknamed_nesting_resource in %w{people}
      it { should route(:get, "/#{nicknamed_nesting_resource}/nickname/followers").to(:action => 'followers', :id => 'nickname') }
      it { should route(:get, "/#{nicknamed_nesting_resource}/nickname/follows").to(:action => 'index', "#{nicknamed_nesting_resource.singularize}_id".to_sym => 'nickname') }
      it { should route(:post, "/#{nicknamed_nesting_resource}/nickname/follows").to(:action => 'create', "#{nicknamed_nesting_resource.singularize}_id".to_sym => 'nickname') }
      it { should route(:delete, "/#{nicknamed_nesting_resource}/nickname/follows").to(:action => 'destroy', :id => 'nickname') }
    end
  end

  describe 'GET index' do
    include_context 'follower support'
    context 'when not logged in' do
      before do
        get :index, :nesting_resource => 'people', :person_id => followed_user.nickname
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in' do
      before do
        sign_in follower_user
        get :index, :nesting_resource => 'people', :person_id => follower_user.nickname
      end
      it_should_behave_like 'the controller responded with template', :index
    end
  end

  describe 'GET followers' do
    include_context 'follower support'
    context 'when not logged in' do
      before do
        get :followers, :nesting_resource => 'people', :id => followed_user.nickname
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in' do
      before do
        sign_in followed_user
        get :followers, :nesting_resource => 'people', :id => follower_user.nickname
      end
      it_should_behave_like 'the controller responded with template', :followers
    end
  end

  describe 'POST create' do
    include_context 'follower support'
    context 'when not logged in' do
      before do
        post :create, :nesting_resource => 'people', :person_id => followed_user.nickname, :format => :js
      end
      it_should_behave_like 'the controller required login on POST'
    end
    context 'when logged in' do
      before do
        sign_in follower_user
        post :create, :nesting_resource => 'people', :person_id => followed_user.nickname, :format => :js
      end
      it_should_behave_like 'the controller responded with template', :create
    end
  end

  describe 'DELETE destroy' do
    include_context 'follower support'
    context 'when not logged in' do
      before do
        delete :destroy, :nesting_resource => 'people', :id => followed_user.nickname, :format => :js
      end
      it_should_behave_like 'the controller required login on POST'
    end
    context 'when logged in' do
      before do
        sign_in follower_user
        delete :destroy, :nesting_resource => 'people', :id => followed_user.nickname, :format => :js
      end
      it_should_behave_like 'the controller responded with template', :destroy
    end
  end
end