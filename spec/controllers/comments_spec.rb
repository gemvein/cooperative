require 'spec_helper'

describe CommentsController do
  routes { Cooperative::Engine.routes }

  describe 'routing' do
    it { should route(:post, '/comments').to(:action => 'create') }
    it { should route(:delete, '/comments/1').to(:action => 'destroy', :id => 1) }
  end

  describe 'POST create' do
    include_context 'comments support'
    context 'when not logged in' do
      before do
        post :create, :comment => {:commentable_id => owned_status.id, :commentable_type => 'Status', :body => 'Lorem ipsum'}, :format => :js
      end
      it_should_behave_like 'the controller required login on POST'
    end
    context 'when logged in as owner' do
      before do
        sign_in follower_user
        post :create, :comment => {:commentable_id => owned_status.id, :commentable_type => 'Status', :body => 'Lorem ipsum'}, :format => :js
      end
      it_should_behave_like 'the controller responded with template', :create
    end
    context 'when logged in as follower' do
      before do
        sign_in follower_user
        post :create, :comment => {:commentable_id => followed_status.id, :commentable_type => 'Status', :body => 'Lorem ipsum'}, :format => :js
      end
      it_should_behave_like 'the controller responded with template', :create
    end
    context 'when logged in as unauthorized' do
      before do
        sign_in follower_user
        post :create, :comment => {:commentable_id => unfollowed_status.id, :commentable_type => 'Status', :body => 'Lorem ipsum'}, :format => :js
      end
      it_should_behave_like 'the controller responded 403: Access Denied'
    end
    context 'when bogus commentable_id given' do
      before do
        sign_in follower_user
        post :create, :comment => {:commentable_id => 10000, :commentable_type => 'Status', :body => 'Lorem ipsum'}, :format => :js
      end
      it_should_behave_like 'the controller responded 404: Page Not Found'
    end
  end

  describe 'DELETE destroy' do
    include_context 'comments support'
    context 'when not logged in' do
      before do
        delete(:destroy, :id => owned_comment.id, :format => :js)
      end
      it_should_behave_like 'the controller required login on POST'
    end
    context 'when logged in as owner' do
      before do
        sign_in follower_user
        delete(:destroy, :id => owned_comment.id, :format => :js)
      end
      it_should_behave_like 'the controller responded with template', :destroy
    end
    context 'when logged in as commentable owner' do
      before do
        sign_in follower_user
        delete(:destroy, :id => followed_comment.id, :format => :js)
      end
      it_should_behave_like 'the controller responded with template', :destroy
    end
    context 'when logged in as unauthorized' do
      before do
        sign_in follower_user
        delete(:destroy, :id => unfollowed_comment.id, :format => :js)
      end
      it_should_behave_like 'the controller responded 403: Access Denied'
    end
    context 'when bogus commentable_id given' do
      before do
        sign_in follower_user
        delete(:destroy, :id => 10000, :format => :js)
      end
      it_should_behave_like 'the controller responded 404: Page Not Found'
    end
  end
end