require 'spec_helper'

describe GroupsController, 'routing' do
  routes { Cooperative::Engine.routes }
  it { should route(:get, '/groups').to(:action => 'index') }
  it { should route(:get, '/groups/1').to(:action => 'show', :id => '1') }
  it { should route(:get, '/groups/new').to(:action => 'new') }
  it { should route(:get, '/groups/1/edit').to(:action => 'edit', :id => '1') }
  it { should route(:post, '/groups').to(:action => 'create') }
  it { should route(:put, '/groups/1').to(:action => 'update', :id => '1') }
  it { should route(:delete, '/groups/1').to(:action => 'destroy', :id => '1') }
  it { should route(:get, '/groups/1/join').to(:action => 'join', :id => '1') }
  it { should route(:get, '/groups/1/leave').to(:action => 'leave', :id => '1') }
end