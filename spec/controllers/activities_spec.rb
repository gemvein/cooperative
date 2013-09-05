require 'spec_helper'

describe ActivitiesController do
  routes { Cooperative::Engine.routes }

  describe 'routing' do
    it { should route(:get, '/activities').to(:action => 'index') }
  end

  describe 'GET index' do
    include_context 'activities support'
    context 'when not logged in' do
      before do
        get :index
      end
      it { should respond_with(:redirect) }
      it { should set_the_flash }
    end
    context 'when logged in' do
      before do
        sign_in follower_user
        get :index
      end
      it { should respond_with(:success) }
      it { should render_template(:index) }
      it { should_not set_the_flash }
    end
  end
end