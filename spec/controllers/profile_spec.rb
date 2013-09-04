require 'spec_helper'

describe ProfileController, 'routing' do
  routes { Cooperative::Engine.routes }
  it { should route(:get, '/profile').to(:action => 'edit') }
  it { should route(:put, '/profile').to(:action => 'update') }
end