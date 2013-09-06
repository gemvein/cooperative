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
    include_context 'messages support'
    context 'when not logged in' do
      before do
        get :index
      end
      it { should respond_with(:redirect) }
      it { should set_the_flash }
    end
    context 'when logged in' do
      before do
        sign_in message_recipient
        get :index
      end
      it { should respond_with(:success) }
      it { should render_template(:index) }
      it { should_not set_the_flash }
    end
  end

  describe 'GET sent' do
    include_context 'messages support'
    context 'when not logged in' do
      before do
        get :sent
      end
      it { should respond_with(:redirect) }
      it { should set_the_flash }
    end
    context 'when logged in' do
      before do
        sign_in message_recipient
        get :sent
      end
      it { should respond_with(:success) }
      it { should render_template(:sent) }
      it { should_not set_the_flash }
    end
  end

  describe 'GET trash' do
    include_context 'messages support'
    context 'when not logged in' do
      before do
        get :trash
      end
      it { should respond_with(:redirect) }
      it { should set_the_flash }
    end
    context 'when logged in' do
      before do
        sign_in message_recipient
        get :trash
      end
      it { should respond_with(:success) }
      it { should render_template(:trash) }
      it { should_not set_the_flash }
    end
  end

  describe 'GET show' do
    include_context 'messages support'
    context 'when not logged in' do
      before do
        get :show, :id => readable_message.id
      end
      it { should respond_with(:redirect) }
      it { should set_the_flash }
    end
    context 'when logged in' do
      before do
        sign_in message_recipient
        get :show, :id => readable_message.id
      end
      it { should respond_with(:success) }
      it { should render_template(:show) }
      it { should_not set_the_flash }
    end
    context 'when bogus id given' do
      before do
        sign_in message_recipient
        get :show, :id => 10000
      end
      it { should respond_with(404) }
      it { should_not set_the_flash }
    end
  end

  describe 'GET new' do
    include_context 'messages support'
    context 'when not logged in' do
      before do
        get :new
      end
      it { should respond_with(:redirect) }
      it { should set_the_flash }
    end
    context 'when logged in' do
      before do
        sign_in message_sender
        get :new
      end
      it { should respond_with(:success) }
      it { should render_template(:new) }
      it { should_not set_the_flash }
    end
  end

  describe 'POST create' do
    include_context 'messages support'
    context 'when not logged in' do
      before do
        post :create
      end
      it { should respond_with(:redirect) }
      it { should set_the_flash }
    end
    context 'when logged in' do
      context 'with invalid attributes' do
        before do
          sign_in message_sender
          post :create
        end
        it { should respond_with(:success) }
        it { should render_template(:new) }
        it { should_not set_the_flash }
      end
      context 'with valid attributes' do
        before do
          sign_in message_sender
          post :create, :message => {:subject => 'Subject', :body => 'Body', :recipient_nickname => message_recipient.nickname}
        end
        it { should respond_with(:redirect) }
        it { should set_the_flash }
      end
    end
  end

  describe 'GET reply' do
    include_context 'messages support'
    context 'when not logged in' do
      before do
        get :reply, :id => child_message.id
      end
      it { should respond_with(:redirect) }
      it { should set_the_flash }
    end
    context 'when logged in, but not as the recipient' do
      before do
        sign_in message_nonrecipient
        get :reply, :id => child_message.id
      end
      it { should respond_with(404) }
      it { should_not set_the_flash }
    end
    context 'when logged in as the recipient' do
      before do
        sign_in message_sender
        get :reply, :id => child_message.id
      end
      it { should respond_with(:success) }
      it { should render_template(:reply) }
      it { should_not set_the_flash }
    end
    context 'when bogus commentable_id given' do
      before do
        sign_in message_sender
        get :reply, :id => 10000
      end
      it { should respond_with(404) }
      it { should_not set_the_flash }
    end
  end

  describe 'GET move_to_trash' do
    include_context 'messages support'
    context 'when not logged in' do
      before do
        get :move_to_trash, :id => readable_message.id
      end
      it { should respond_with(:redirect) }
      it { should set_the_flash }
    end
    context 'when logged in, but not as the owner' do
      before do
        sign_in message_nonrecipient
        get :move_to_trash, :id => readable_message.id
      end
      it { should respond_with(404) }
      it { should_not set_the_flash }
    end
    context 'when logged in as owner' do
      before do
        sign_in message_sender
        get :move_to_trash, :id => readable_message.id
      end
      it { should respond_with(:redirect) }
      it { should set_the_flash }
    end
    context 'when bogus commentable_id given' do
      before do
        sign_in message_sender
        get :move_to_trash, :id => 10000
      end
      it { should respond_with(404) }
      it { should_not set_the_flash }
    end
  end

  describe 'GET restore' do
    include_context 'messages support'
    context 'when not logged in' do
      before do
        get :restore, :id => readable_message.id
      end
      it { should respond_with(:redirect) }
      it { should set_the_flash }
    end
    context 'when logged in, but not as the owner' do
      before do
        sign_in message_nonrecipient
        get :restore, :id => readable_message.id
      end
      it { should respond_with(404) }
      it { should_not set_the_flash }
    end
    context 'when logged in as owner' do
      before do
        sign_in message_sender
        get :restore, :id => readable_message.id
      end
      it { should respond_with(:redirect) }
    end
    context 'when bogus commentable_id given' do
      before do
        sign_in message_sender
        get :restore, :id => 10000
      end
      it { should respond_with(404) }
      it { should_not set_the_flash }
    end
  end
end