require 'spec_helper'

describe PeopleController, 'routing' do

  routes { Cooperative::Engine.routes }
  it { should route(:get, '/people').to(:action => 'index') }
  it { should route(:get, '/people/nickname').to(:action => 'show', :id => 'nickname') }

  describe 'GET index' do

    include BasicUsersContext
    context 'when not logged in' do
      before :each do
        get :index
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in' do
      before :each do
        sign_in follower_user
        get :index
      end
      it_should_behave_like 'the controller responded with template', :index
    end
  end

  describe 'GET show' do

    include BasicUsersContext
    context 'when not logged in' do
      before :each do
        get :show, :id => followed_user.nickname
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in' do
      before :each do
        sign_in follower_user
        get :show, :id => followed_user.nickname
      end
      it_should_behave_like 'the controller responded with template', :show
    end
  end
end