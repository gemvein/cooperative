require 'spec_helper'

describe ProfileController, 'routing' do

  routes { Cooperative::Engine.routes }
  it { should route(:get, '/profile').to(:action => 'edit') }
  it { should route(:put, '/profile').to(:action => 'update') }

  describe 'GET edit' do

    include BasicUsersContext
    context 'when not logged in' do
      before :each do
        get :edit
      end
      it { should respond_with(302) }
      it { should set_the_flash }
    end
    context 'when logged in' do
      before :each do
        sign_in followed_user
        get :edit
      end
      it_should_behave_like 'the controller responded with template', :edit
    end
  end

  describe 'PUT update' do

    include BasicUsersContext
    context 'when not logged in' do
      before :each do
        put :update
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in' do
      context 'with invalActivitiesContext.followed_user' do
        before :each do
          sign_in followed_user
          put :update, :profile => {:bio => 'Lorem ipsum'}
        end

        it { should respond_with(:redirect) }
        it { should set_the_flash }
      end
    end
  end
end