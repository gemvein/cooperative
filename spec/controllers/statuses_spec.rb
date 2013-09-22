require 'spec_helper'

describe StatusesController, 'routing' do

  routes { Cooperative::Engine.routes }
  it { should route(:get, '/statuses/new').to(:action => 'new') }
  it { should route(:post, '/statuses').to(:action => 'create') }
  it { should route(:get, '/statuses/1').to(:action => 'show', :id => 1) }
  it { should route(:delete, '/statuses/1').to(:action => 'destroy', :id => 1) }
  it { should route(:get, '/statuses/grab').to(:action => 'grab') }

  describe 'GET show' do
    extend Statuses
    context 'when the status is public' do
      before do
        get :show, :id => public_status.id
      end
      it_should_behave_like 'the controller responded with template', :show
    end
    context 'when the status is limited access' do
      context 'when not logged in' do
        before do
          get :show, :id => unshared_status.id
        end
        it { should respond_with(:redirect) }
        it { should set_the_flash }
      end
      context 'when logged in but not authorized' do
        before do
          sign_in unfollowed_user
          get :show, :id => unshared_status.id
        end
        it_should_behave_like 'the controller responded successful verbose redirect'
      end
      context 'when authorized' do
        before do
          sign_in ActivitiesContext.follower_user
          get :show, :id => unshared_status.id
        end
        it_should_behave_like 'the controller responded with template', :show
      end
    end
  end
  describe 'GET new' do
    extend Statuses
    context 'when not logged in' do
      before do
        get :new
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in' do
      before do
        sign_in followed_user
        get :new
      end
      it_should_behave_like 'the controller responded with template', :new
    end
  end
  describe 'POST create' do
    extend Statuses
    context 'when not logged in' do
      before do
        post :create, :format => 'js'
      end
      it_should_behave_like 'the controller required login on POST'
    end
    context 'when logged in' do
      context 'with invalid attributes' do
        before do
          sign_in followed_user
          post :create, :format => 'js'
        end
        it_should_behave_like 'the controller responded with template', :create
      end
      context 'with valid attributes' do
        before do
          sign_in followed_user
          post :create, :status => {:body => 'Body'}, :format => 'js'
        end
        it_should_behave_like 'the controller responded with template', :create
      end
    end
  end
  describe 'DELETE destroy' do
    extend Statuses
    context 'when not logged in' do
      before do
        delete :destroy, :id => unshared_status.id, :format => 'js'
      end
      it_should_behave_like 'the controller required login on POST'
    end
    context 'when logged in, but not as the owner' do
      before do
        sign_in unfollowed_user
        delete :destroy, :id => unshared_status.id, :format => 'js'
      end
      it_should_behave_like 'the controller responded 403: Access Denied'
    end
    context 'when logged in as owner' do
      before do
        sign_in followed_user
        delete :destroy, :id => unshared_status.id, :format => 'js'
      end
      it_should_behave_like 'the controller responded with template', :destroy
    end
    context 'when bogus commentable_id given' do
      before do
        sign_in followed_user
        delete :destroy, :id => 10000, :format => 'js'
      end
      it_should_behave_like 'the controller responded 404: Page Not Found'
    end
  end

  describe 'GET grab' do

    extend Followers
    context 'when not logged in' do
      before do
        get :grab, :uri => 'http://www.queenoftarot.com/', :format => 'js'
      end
      it_should_behave_like 'the controller required login on POST'
    end
    context 'when logged in' do
      before do
        sign_in followed_user
        get :grab, :uri => 'http://www.queenoftarot.com/', :format => 'js'
      end
      it_should_behave_like 'the controller responded with template', :grab
    end
  end
end