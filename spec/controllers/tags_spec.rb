require 'spec_helper'

describe TagsController, 'routing' do

  routes { Cooperative::Engine.routes }
  it { should route(:get, '/tags').to(:action => 'index') }
  it { should route(:get, '/tags/foo').to(:action => 'show', :id => 'foo') }

  describe 'GET index' do
    it_should_behave_like 'the controller responded with template', :index do
      include TagsContext
      before :each do
        get :index
      end

    end
  end

  describe 'GET show' do

    it_should_behave_like 'the controller responded with template', :show do
      include TagsContext
      before :each do
        get :show, :id => 'reading'
      end

    end
  end
end