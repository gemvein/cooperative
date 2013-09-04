require 'spec_helper'

describe PeopleController, 'routing' do
  routes { Cooperative::Engine.routes }
  it { should route(:get, '/people').to(:action => 'index') }
  it { should route(:get, '/people/nickname').to(:action => 'show', :id => 'nickname') }
end