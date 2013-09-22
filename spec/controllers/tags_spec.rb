require 'spec_helper'

describe TagsController, 'routing' do

  routes { Cooperative::Engine.routes }
  it { should route(:get, '/tags').to(:action => 'index') }
  it { should route(:get, '/tags/foo').to(:action => 'show', :id => 'foo') }

  describe 'GET index' do
    extend Tags
    before do
      get :index
    end
    it_should_behave_like 'the controller responded with template', :index
  end

  describe 'GET show' do
    extend Tags
    before do
      get :show, :id => 'reading'
    end
    it_should_behave_like 'the controller responded with template', :show
  end
end