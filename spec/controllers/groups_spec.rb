require 'spec_helper'

describe GroupsController do

  routes { Cooperative::Engine.routes }
  describe 'routing' do
    it { should route(:get, '/groups').to(:action => 'index') }
    it { should route(:get, '/groups/1').to(:action => 'show', :id => '1') }
    it { should route(:get, '/groups/new').to(:action => 'new') }
    it { should route(:post, '/groups').to(:action => 'create') }
    it { should route(:get, '/groups/1/edit').to(:action => 'edit', :id => '1') }
    it { should route(:put, '/groups/1').to(:action => 'update', :id => '1') }
    it { should route(:delete, '/groups/1').to(:action => 'destroy', :id => '1') }
    it { should route(:get, '/groups/1/join').to(:action => 'join', :id => '1') }
    it { should route(:get, '/groups/1/leave').to(:action => 'leave', :id => '1') }
  end

  describe 'GET index' do
    extend Groups
    context 'when not logged in' do
      before do
        get :index
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in' do
      before do
        sign_in group_member
        get :index
      end
      it_should_behave_like 'the controller responded with template', :index
    end
  end

  describe 'GET show' do
    extend Groups
    context 'when not logged in' do
      before do
        get :show, :id => public_group.id
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in' do
      before do
        sign_in group_member
        get :show, :id => public_group.id
      end
      it_should_behave_like 'the controller responded with template', :show
    end
    context 'when bogus id given' do
      before do
        sign_in group_member
        get :show, :id => 10000
      end
      it_should_behave_like 'the controller responded 404: Page Not Found'
    end
  end

  describe 'GET new' do
    extend Groups
    context 'when not logged in' do
      before do
        get :new
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in' do
      before do
        sign_in group_owner
        get :new
      end
      it_should_behave_like 'the controller responded with template', :new
    end
  end

  describe 'POST create' do
    extend Groups
    context 'when not logged in' do
      before do
        post :create
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in' do
      context 'with invalid attributes' do
        before do
          sign_in group_owner
          post :create
        end
        it_should_behave_like 'the controller responded with template', :new
      end
      context 'with valid attributes' do
        before do
          sign_in group_owner
          post :create, :group => {:name => 'Group'}
        end
        it_should_behave_like 'the controller responded successful verbose redirect'
      end
    end
  end

  describe 'GET edit' do
    extend Groups
    context 'when not logged in' do
      before do
        get :edit, :id => owned_group.id
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in, but not as the owner' do
      before do
        sign_in group_member
        get :edit, :id => owned_group.id
      end
      it_should_behave_like 'the controller responded 403: Access Denied'
    end
    context 'when logged in as owner' do
      before do
        sign_in group_owner
        get :edit, :id => owned_group.id
      end
      it_should_behave_like 'the controller responded with template', :edit
    end
    context 'when bogus commentable_id given' do
      before do
        sign_in group_owner
        get :edit, :id => 10000
      end
      it_should_behave_like 'the controller responded 404: Page Not Found'
    end
  end

  describe 'PUT update' do
    extend Groups
    context 'when not logged in' do
      before do
        put :update, :id => owned_group.id, :group => {:name => 'Edited'}
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in, but not as the owner' do
      before do
        sign_in group_member
        put :update, :id => owned_group.id, :group => {:name => 'Edited'}
      end
      it_should_behave_like 'the controller responded 403: Access Denied'
    end
    context 'when logged in as owner' do
      context 'with invalid attributes' do
        before do
          sign_in group_owner
          put :update, :id => owned_group.id, :group => {:name => ''}
        end
        it_should_behave_like 'the controller responded with template', :edit
      end
      context 'with valid attributes' do
        before do
          sign_in group_owner
          put :update, :id => owned_group.id, :group => {:name => 'Edited'}
        end
        it_should_behave_like 'the controller responded successful verbose redirect'
      end
    end
    context 'when bogus commentable_id given' do
      before do
        sign_in group_member
        put :update, :id => 10000, :group => {:name => 'Edited'}
      end
      it_should_behave_like 'the controller responded 404: Page Not Found'
    end
  end

  describe 'DELETE destroy' do
    extend Groups
    context 'when not logged in' do
      before do
        delete :destroy, :id => owned_group.id
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in, but not as the owner' do
      before do
        sign_in group_member
        delete :destroy, :id => owned_group.id
      end
      it_should_behave_like 'the controller responded 403: Access Denied'
    end
    context 'when logged in as owner' do
      before do
        sign_in group_owner
        delete :destroy, :id => owned_group.id
      end
      it { should respond_with(:redirect) }
    end
    context 'when bogus commentable_id given' do
      before do
        sign_in group_member
        delete :destroy, :id => 10000
      end
      it_should_behave_like 'the controller responded 404: Page Not Found'
    end
  end

  describe 'GET join' do
    extend Groups
    context 'when not logged in' do
      before do
        get :join, :id => public_group.id, :format => 'js'
      end
      it_should_behave_like 'the controller required login on POST'
    end
    context 'when logged in' do
      before do
        sign_in group_joiner
        get :join, :id => public_group.id, :format => 'js'
      end
      it_should_behave_like 'the controller responded with template', :join
    end
    context 'when bogus id given' do
      before do
        sign_in group_joiner
        get :join, :id => 10000, :format => 'js'
      end
      it_should_behave_like 'the controller responded 404: Page Not Found'
    end
  end

  describe 'GET leave' do
    extend Groups
    context 'when not logged in' do
      before do
        get :leave, :id => public_group.id, :format => 'js'
      end
      it_should_behave_like 'the controller required login on POST'
    end
    context 'when logged in' do
      before do
        sign_in group_member
        get :leave, :id => owned_group.id, :format => 'js'
      end
      it_should_behave_like 'the controller responded with template', :leave
    end
    context 'when bogus id given' do
      before do
        sign_in group_member
        get :leave, :id => 10000, :format => 'js'
      end
      it_should_behave_like 'the controller responded 404: Page Not Found'
    end
  end
end