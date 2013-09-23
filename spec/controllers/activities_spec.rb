require 'spec_helper'

describe ActivitiesController do
  routes { Cooperative::Engine.routes }

  describe 'routing' do
    it { should route(:get, '/').to(:action => 'index') }
  end

  describe 'GET index' do
    context 'when not logged in' do
      it_should_behave_like 'the controller required login on GET' do
        include BasicUsersContext
        before do
          get :index
        end
      end
    end
    context 'when logged in' do
      it_should_behave_like 'the controller responded with template', :index do
        include ActivitiesContext
        before do
          sign_in follower_user
          get :index
        end
      end
    end
  end
end