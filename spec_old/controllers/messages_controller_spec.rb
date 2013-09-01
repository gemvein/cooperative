require 'spec_helper'

describe MessagesController do
  include_context "pages support"
  include_context "messages support"
  describe "GET index" do
    it "does not show messages when not logged in" do
      get :index
      assigns(:messages).should be nil
    end
    it "assigns received message threads to @messages" do
      sign_in :user, @recipient 
      get :index
      assigns(:messages).should eq(@grandparents)
      response.should render_template("index")
    end
  end
  describe "GET sent" do
    it "assigns sent message threads to @messages" do
      sign_in :user, @recipient 
      get :sent
      assigns(:messages).should eq(@grandparents[0..3])
      response.should render_template("sent")
    end
  end
  describe "GET trash" do
    it "assigns sent message threads to @messages" do
      sign_in :user, @recipient 
      last_message = @recipient.messages.last
      last_message.move_to_trash(@recipient)
      get :trash
      assigns(:messages).should eq([last_message.thread])
      response.should render_template("trash")
    end
  end
  describe "GET show" do
    it "shows a message on request" do
      sign_in :user, @recipient 
      message = @recipient.messages.first
      get :show, {:id => message.id}
      assigns(:message).should eq(message)
      response.should render_template("show")
    end
  end
  describe "GET new" do
    it "builds a new record" do
      sign_in :user, @sender 
      get :new
      assigns(:message).new_record?.should be true
      response.should render_template("new")
    end
  end
  describe "POST create" do
    it "sends a new message" do
      sign_in :user, @sender 
      message = {:recipient_nickname => @recipient.nickname, :subject => 'subject', :body => 'body'}
      post :create, :message => message
      # It should be 38.  I counted.
      response.should redirect_to('/messages/38')
    end
  end
  describe "GET reply" do
    it "builds a new reply" do
      sign_in :user, @recipient 
      message = @messages.last
      get :reply, :id => message.id
      assigns(:message).new_record?.should be true
      response.should render_template("reply")
    end
  end
  describe "GET move_to_trash" do
    it "moves the message to the trash" do
      sign_in :user, @recipient 
      message = @messages.last
      get :move_to_trash, :id => message.id
      message.reload.deleted_by_recipient.should == true
      response.should redirect_to('/messages')
    end
  end
  describe "GET restore" do
    it "moves the message out of the trash" do
      sign_in :user, @recipient 
      message = @messages.last
      get :move_to_trash, :id => message.id
      message.reload.deleted_by_recipient.should == true
      get :restore, :id => message.id
      message.reload.deleted_by_recipient.should == false
      response.should redirect_to('/messages')
    end
  end
end