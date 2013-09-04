require 'spec_helper'

describe MessagesController, 'routing' do
  routes { Cooperative::Engine.routes }
  it { should route(:get, '/messages').to(:action => 'index') }
  it { should route(:get, '/messages/trash').to(:action => 'trash') }
  it { should route(:get, '/messages/sent').to(:action => 'sent') }
  it { should route(:get, '/messages/1').to(:action => 'show', :id => '1') }
  it { should route(:get, '/messages/new').to(:action => 'new') }
  it { should route(:post, '/messages').to(:action => 'create') }
  it { should route(:get, '/messages/1/move_to_trash').to(:action => 'move_to_trash', :id => '1') }
  it { should route(:get, '/messages/1/restore').to(:action => 'restore', :id => '1') }
  it { should route(:get, '/messages/1/reply').to(:action => 'reply', :id => '1') }
end