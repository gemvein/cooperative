require 'spec_helper'

describe TagsController do
  routes { Cooperative::Engine.routes }
  describe 'routing' do
    it { should route(:get, '/tags').to(:action => 'index') }
    it { should route(:get, '/tags/foo').to(:action => 'show', :id => 'foo') }
  end

  describe 'GET index' do
    include SharedBehaviors
    it_should_behave_like 'the controller responded with template', :index do
      include TagsContext
      before :each do
        get :index
      end
    end
  end

  describe 'GET show' do
    include SharedBehaviors
    it_should_behave_like 'the controller responded with template', :show do
      include TagsContext
      before :each do
        get :show, :id => 'reading'
      end

    end
  end
end