require 'spec_helper'

describe CommentsController, 'routing' do
  routes { Cooperative::Engine.routes }
  it { should route(:get, '/comments/new').to(:action => 'new') }
  it { should route(:post, '/comments').to(:action => 'create') }
  it { should route(:get, '/comments/1').to(:action => 'show', :id => 1) }
  it { should route(:delete, '/comments/1').to(:action => 'destroy', :id => 1) }

  for nesting_resource in %w{statuses}
    it { should route(:get, "/#{nesting_resource}/1/comments").to(:action => 'index', "#{nesting_resource.singularize}_id".to_sym => 1) }
  end
end