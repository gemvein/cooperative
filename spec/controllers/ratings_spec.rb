require 'spec_helper'

describe RatingsController, 'routing' do
  routes { Cooperative::Engine.routes }
  for nesting_resource in %w{statuses}
    it { should route(:get, "/#{nesting_resource}/1/rate/2").to(:action => 'rate', :id => 1, :rating => 2) }
    it { should route(:get, "/#{nesting_resource}/1/rate/-2").to(:action => 'rate', :id => 1, :rating => -2) }
    it { should route(:get, "/#{nesting_resource}/1/rate/2.0").to(:action => 'rate', :id => 1, :rating => 2.0) }
    it { should route(:get, "/#{nesting_resource}/1/rate/-2.0").to(:action => 'rate', :id => 1, :rating => -2.0) }
    it { should_not route(:get, "/#{nesting_resource}/1/rate/hacker").to(:action => 'rate', :id => 1, :rating => 'hacker') }
    it { should route(:get, "/#{nesting_resource}/1/unrate").to(:action => 'unrate', :id => 1) }
  end
end