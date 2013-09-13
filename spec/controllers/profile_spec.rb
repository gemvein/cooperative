require 'spec_helper'

describe ProfileController, 'routing' do
  routes { Cooperative::Engine.routes }
  it { should route(:get, '/profile').to(:action => 'edit') }
  it { should route(:put, '/profile').to(:action => 'update') }

  describe 'GET edit' do
    include_context 'follower support'
    context 'when not logged in' do
      before do
        get :edit
      end
      it { should respond_with(302) }
      it { should set_the_flash }
    end
    context 'when logged in' do
      before do
        sign_in followed_user
        get :edit
      end
      it { should respond_with(:success) }
      it { should render_template(:edit) }
      it { should_not set_the_flash }
    end
  end

  describe 'PUT update' do
    include_context 'follower support'
    context 'when not logged in' do
      before do
        put :update
      end
      it { should respond_with(:redirect) }
      it { should set_the_flash }
    end
    context 'when logged in' do
      context 'with invalid attributes' do
        before do
          sign_in followed_user
          put :update, :profile => {:bio => 'Lorem ipsum'}
        end
        it { should respond_with(:redirect) }
        it { should set_the_flash }
      end
    end
  end
end