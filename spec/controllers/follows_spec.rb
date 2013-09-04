require 'spec_helper'

describe FollowsController, 'routing' do
  routes { Cooperative::Engine.routes }
  for nicknamed_nesting_resource in %w{people}
    it { should route(:get, "/#{nicknamed_nesting_resource}/nickname/followers").to(:action => 'followers', :id => 'nickname') }
    it { should route(:get, "/#{nicknamed_nesting_resource}/nickname/follows").to(:action => 'index', "#{nicknamed_nesting_resource.singularize}_id".to_sym => 'nickname') }
    it { should route(:post, "/#{nicknamed_nesting_resource}/nickname/follows").to(:action => 'create', "#{nicknamed_nesting_resource.singularize}_id".to_sym => 'nickname') }
    it { should route(:delete, "/#{nicknamed_nesting_resource}/nickname/follows/1").to(:action => 'destroy', "#{nicknamed_nesting_resource.singularize}_id".to_sym => 'nickname', :id => 1) }
  end
end