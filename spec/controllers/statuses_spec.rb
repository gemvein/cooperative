require 'spec_helper'

describe StatusesController, 'routing' do
  routes { Cooperative::Engine.routes }
  it { should route(:get, '/statuses/new').to(:action => 'new') }
  it { should route(:post, '/statuses').to(:action => 'create') }
  it { should route(:get, '/statuses/1').to(:action => 'show', :id => 1) }
  it { should route(:delete, '/statuses/1').to(:action => 'destroy', :id => 1) }
  it { should route(:get, '/statuses/grab').to(:action => 'grab') }
end