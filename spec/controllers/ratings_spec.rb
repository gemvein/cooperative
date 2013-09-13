require 'spec_helper'

describe RatingsController, 'routing' do
  routes { Cooperative::Engine.routes }
  for nesting_resource in %w{statuses}
    it { should route(:get, "/#{nesting_resource}/1/rate/2").to(:action => 'rate', :id => 1, :rating => 2) }
    it { should route(:get, "/#{nesting_resource}/1/rate/-2").to(:action => 'rate', :id => 1, :rating => -2) }
    it { should route(:get, "/#{nesting_resource}/1/rate/2.0").to(:action => 'rate', :id => 1, :rating => 2.0) }
    it { should route(:get, "/#{nesting_resource}/1/rate/-2.0").to(:action => 'rate', :id => 1, :rating => -2.0) }
    it { should_not route(:get, "/#{nesting_resource}/1/rate/hacker").to(:action => 'rate', :id => 1, :rating => 'hacker') }
    it { should route(:get, "/#{nesting_resource}/1/unrate").to(:action => 'unrate', :id => 1) }
  end

  describe 'GET rate' do
    include_context 'activities support'
    context 'when not logged in' do
      before do
        get :rate, :nesting_resource => 'statuses', :id => followed_status.id, :rating => 1, :format => 'js'
      end
      it { should respond_with(401) }
      it { should_not set_the_flash }
    end
    context 'when logged in' do
      context 'as unauthorized' do
        before do
          sign_in unfollowed_user
          get :rate, :nesting_resource => 'statuses', :id => followed_status.id, :rating => 1, :format => 'js'
        end
        it { should respond_with(403) }
        it { should_not set_the_flash }
      end
      context 'as authorized' do
        before do
          sign_in follower_user
          get :rate, :nesting_resource => 'statuses', :id => followed_status.id, :rating => 1, :format => 'js'
        end
        it { should respond_with(:success) }
        it { should render_template(:rate) }
        it { should_not set_the_flash }
      end
    end
  end

  describe 'GET unrate' do
    include_context 'activities support'
    context 'when not logged in' do
      before do
        get :rate, :nesting_resource => 'statuses', :id => followed_status.id, :rating => 1, :format => 'js'
      end
      it { should respond_with(401) }
      it { should_not set_the_flash }
    end
    context 'when logged in' do
      context 'as unauthorized' do
        before do
          sign_in unfollowed_user
          get :rate, :nesting_resource => 'statuses', :id => followed_status.id, :rating => 1, :format => 'js'
        end
        it { should respond_with(403) }
        it { should_not set_the_flash }
      end
      context 'as authorized' do
        before do
          sign_in follower_user
          get :rate, :nesting_resource => 'statuses', :id => followed_status.id, :rating => 1, :format => 'js'
        end
        it { should respond_with(:success) }
        it { should render_template(:rate) }
        it { should_not set_the_flash }
      end
    end
  end
end