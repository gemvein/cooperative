require 'spec_helper'

describe Message do
  it "can create a message" do
    sender = FactoryGirl.create(:user)
    recipient = FactoryGirl.create(:user)
    
    count = Message.count
    message = FactoryGirl.create(:message, :sender_id => sender.id, :recipient_nickname => recipient.nickname)
    Message.count.should be count + 1
  end
  it "can set a message to recipient deleted and then restore it" do
    sender = FactoryGirl.create(:user)
    recipient = FactoryGirl.create(:user)
    message = FactoryGirl.create(:message, :sender_id => sender.id, :recipient_nickname => recipient.nickname)
    message.move_to_trash(recipient)
    message.reload.deleted_by_recipient.should == true
    message.restore(recipient)
    message.reload.deleted_by_recipient.should == false
  end
  it "can set a message to sender deleted and then restore it" do
    sender = FactoryGirl.create(:user)
    recipient = FactoryGirl.create(:user)
    message = FactoryGirl.create(:message, :sender_id => sender.id, :recipient_nickname => recipient.nickname)
    message.move_to_trash(sender)
    message.reload.deleted_by_sender.should == true
    message.restore(sender)
    message.reload.deleted_by_sender.should == false
  end
  it "can set a message to read" do
    sender = FactoryGirl.create(:user)
    recipient = FactoryGirl.create(:user)
    message = FactoryGirl.create(:message, :sender_id => sender.id, :recipient_nickname => recipient.nickname)
    
    # This shouldn't work
    message.mark_as_read_by(sender)
    message.reload.read_at.should == nil
    
    # But this should
    message.reload.unread?(recipient).should == true
    message.mark_as_read_by(recipient)
    message.reload.read_at.should_not == nil
    message.reload.unread?(recipient).should == false
  end
  
  it "can deal with threads" do
    sender = FactoryGirl.create(:user)
    recipient = FactoryGirl.create(:user)
    grandparent = FactoryGirl.create(:message, :sender_id => sender.id, :recipient_nickname => recipient.nickname)
    parent = FactoryGirl.create(:message, :sender_id => recipient.id, :recipient_nickname => sender.nickname, :parent_id =>grandparent.id)
    message = FactoryGirl.create(:message, :sender_id => sender.id, :recipient_nickname => recipient.nickname, :parent_id =>parent.id)
    message.thread.should == grandparent
    message.parent.should == parent
    grandparent.thread_count.should == 3
  end
  
  it "should not send a message to the sender" do
    sender = FactoryGirl.create(:user)
    message = FactoryGirl.build(:message, :sender_id => sender.id, :recipient_nickname => sender.nickname)
    message.save.should == false
    message.errors[:recipient_nickname].should == ["can't be yourself"]
  end
  
  it "can say who a message is with" do
    sender = FactoryGirl.create(:user)
    recipient = FactoryGirl.create(:user)
    message = FactoryGirl.create(:message, :sender_id => sender.id, :recipient_nickname => recipient.nickname)
    message.with(sender).should == recipient
    message.with(recipient).should == sender
  end
  
  it "can limit results to unread messages" do
    sender = FactoryGirl.create(:user)
    recipient = FactoryGirl.create(:user)
    messages = []
    7.times do
      messages << FactoryGirl.create(:message, :sender_id => sender.id, :recipient_nickname => recipient.nickname)
    end
    3.times do |index|
      messages[index].mark_as_read_by(recipient)
    end
    Message.unread.count.should == 4
  end
  
  it "can find just the threads from a list of messages" do
    sender = FactoryGirl.create(:user)
    recipient = FactoryGirl.create(:user)
    grandparents = []
    5.times do
      grandparents << FactoryGirl.create(:message, :sender_id => sender.id, :recipient_nickname => recipient.nickname)
    end
    parents = []
    4.times do |index|
      3.times do
        parents << FactoryGirl.create(:message, :sender_id => recipient.id, :recipient_nickname => sender.nickname, :parent_id => grandparents[index].id)
      end
    end
    messages = []
    10.times do |index|
      2.times do
        messages << FactoryGirl.create(:message, :sender_id => sender.id, :recipient_nickname => recipient.nickname, :parent_id => parents[index].id)
      end
    end
    Message.count.should == grandparents.count + parents.count + messages.count
    Message.threads(Message.find(:all)).should == grandparents
  end
end
