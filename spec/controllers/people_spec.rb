require 'spec_helper'

describe PeopleController, 'routing' do
  routes { Cooperative::Engine.routes }
  it { should route(:get, '/people').to(:action => 'index') }
  it { should route(:get, '/people/nickname').to(:action => 'show', :id => 'nickname') }

  describe 'GET index' do
    include_context 'follower support'
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

  describe 'GET show' do
    include_context 'follower support'
    context 'when not logged in' do
      before do
        get :show, :id => followed_user.nickname
      end
      it { should respond_with(:redirect) }
      it { should set_the_flash }
    end
    context 'when logged in' do
      before do
        sign_in follower_user
        get :show, :id => followed_user.nickname
      end
      it { should respond_with(:success) }
      it { should render_template(:show) }
      it { should_not set_the_flash }
    end
  end
end