require 'spec_helper'

describe ActivitiesController do

  routes { Cooperative::Engine.routes }

  describe 'routing' do
    it { should route(:get, '/').to(:action => 'index') }
  end

  describe 'GET index' do
    extend Activities
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
end