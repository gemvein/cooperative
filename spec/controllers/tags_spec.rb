require 'spec_helper'

describe TagsController, 'routing' do
  routes { Cooperative::Engine.routes }
  it { should route(:get, '/tags').to(:action => 'index') }
  it { should route(:get, '/tags/foo').to(:action => 'show', :id => 'foo') }
end