require 'spec_helper'

describe MessagesController do

  routes { Cooperative::Engine.routes }

  describe 'routing' do
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

  describe 'GET index' do
    include MessagesContext
    context 'when not logged in' do
      before :each do
        get :index
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in' do
      before :each do
        sign_in message_recipient
        get :index
      end
      it_should_behave_like 'the controller responded with template', :index
    end
  end

  describe 'GET sent' do
    include MessagesContext
    context 'when not logged in' do
      before :each do
        get :sent
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in' do
      before :each do
        sign_in message_recipient
        get :sent
      end
      it_should_behave_like 'the controller responded with template', :sent
    end
  end

  describe 'GET trash' do
    include MessagesContext
    context 'when not logged in' do
      before :each do
        get :trash
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in' do
      before :each do
        sign_in message_recipient
        get :trash
      end
      it_should_behave_like 'the controller responded with template', :trash
    end
  end

  describe 'GET show' do
    include MessagesContext
    context 'when not logged in' do
      before :each do
        get :show, :id => readable_message.id
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in' do
      before :each do
        sign_in message_recipient
        get :show, :id => readable_message.id
      end
      it_should_behave_like 'the controller responded with template', :show
    end
    context 'when bogus id given' do
      before :each do
        sign_in message_recipient
        get :show, :id => 10000
      end
      it_should_behave_like 'the controller responded 404: Page Not Found'
    end
  end

  describe 'GET new' do
    include MessagesContext
    context 'when not logged in' do
      before :each do
        get :new
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in' do
      before :each do
        sign_in message_sender
        get :new
      end
      it_should_behave_like 'the controller responded with template', :new
    end
  end

  describe 'POST create' do
    include MessagesContext
    context 'when not logged in' do
      before :each do
        post :create
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in' do
      context 'with invalid attributes' do
        before :each do
          sign_in message_sender
          post :create
        end

        it_should_behave_like 'the controller responded with template', :new
      end
      context 'with valid attributes' do
        before :each do
          sign_in message_sender
          post :create, :message => {:subject => 'Subject', :body => 'Body', :recipient_nickname => message_recipient.nickname}
        end

        it_should_behave_like 'the controller responded successful verbose redirect'
      end
    end
  end

  describe 'GET reply' do
    include MessagesContext
    context 'when not logged in' do
      before :each do
        get :reply, :id => child_message.id
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in, but not as the recipient' do
      before :each do
        sign_in message_nonrecipient
        get :reply, :id => child_message.id
      end
      it_should_behave_like 'the controller responded 403: Access Denied'
    end
    context 'when logged in as the recipient' do
      before :each do
        sign_in message_sender
        get :reply, :id => child_message.id
      end
      it_should_behave_like 'the controller responded with template', :reply
    end
    context 'when bogus commentable_id given' do
      before :each do
        sign_in message_sender
        get :reply, :id => 10000
      end
      it_should_behave_like 'the controller responded 404: Page Not Found'
    end
  end

  describe 'GET move_to_trash' do
    include MessagesContext
    context 'when not logged in' do
      before :each do
        get :move_to_trash, :id => readable_message.id
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in, but not as the owner' do
      before :each do
        sign_in message_nonrecipient
        get :move_to_trash, :id => readable_message.id
      end
      it_should_behave_like 'the controller responded 403: Access Denied'
    end
    context 'when logged in as owner' do
      before :each do
        sign_in message_sender
        get :move_to_trash, :id => readable_message.id
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when bogus commentable_id given' do
      before :each do
        sign_in message_sender
        get :move_to_trash, :id => 10000
      end
      it_should_behave_like 'the controller responded 404: Page Not Found'
    end
  end

  describe 'GET restore' do
    include MessagesContext
    context 'when not logged in' do
      before :each do
        get :restore, :id => readable_message.id
      end
      it_should_behave_like 'the controller required login on GET'
    end
    context 'when logged in, but not as the owner' do
      before :each do
        sign_in message_nonrecipient
        get :restore, :id => readable_message.id
      end
      it_should_behave_like 'the controller responded 403: Access Denied'
    end
    context 'when logged in as owner' do
      before :each do
        sign_in message_sender
        get :restore, :id => readable_message.id
      end
      it_should_behave_like 'the controller responded successful verbose redirect'
    end
    context 'when bogus commentable_id given' do
      before :each do
        sign_in message_sender
        get :restore, :id => 10000
      end
      it_should_behave_like 'the controller responded 404: Page Not Found'
    end
  end
end