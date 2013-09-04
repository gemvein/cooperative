require 'spec_helper'

describe ActivitiesController, 'routing' do
  routes { Cooperative::Engine.routes }
  it { should route(:get, '/activities').to(:action => 'index') }
end