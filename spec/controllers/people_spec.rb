require 'spec_helper'

describe PeopleController, 'routing' do

  routes { Cooperative::Engine.routes }
  it { should route(:get, '/people').to(:action => 'index') }
  it { should route(:get, '/people/nickname').to(:action => 'show', :id => 'nickname') }

  describe 'GET index' do

    extend Followers
    context 'when not logged in' do
      before do
        get :index
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in' do
      before do
        sign_in ActivitiesContext.follower_user
        get :index
      end
      it_should_behave_like 'the controller responded with template', :index
    end
  end

  describe 'GET show' do

    extend Followers
    context 'when not logged in' do
      before do
        get :show, :id => followed_user.nickname
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in' do
      before do
        sign_in ActivitiesContext.follower_user
        get :show, :id => followed_user.nickname
      end
      it_should_behave_like 'the controller responded with template', :show
    end
  end
end