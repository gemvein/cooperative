require 'spec_helper'

describe TagsController, 'routing' do
  routes { Cooperative::Engine.routes }
  it { should route(:get, '/tags').to(:action => 'index') }
  it { should route(:get, '/tags/foo').to(:action => 'show', :id => 'foo') }

  describe 'GET index' do
    include_context 'tags support'
    before do
      get :index
    end
    it { should respond_with(:success) }
    it { should render_template(:index) }
    it { should_not set_the_flash }
  end

  describe 'GET show' do
    include_context 'tags support'
    before do
      get :show, :id => 'reading'
    end
    it { should respond_with(:success) }
    it { should render_template(:show) }
    it { should_not set_the_flash }
  end
end