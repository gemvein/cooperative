module MessagesContext
  def self.included(base)
    base.class_eval do
      extend RSpec::SharedContext
      before :each do
        message_sender =   FactoryGirl.create(:user)
        message_recipient =   FactoryGirl.create(:user)
        message_nonrecipient =   FactoryGirl.create(:user)

        unread_message =   FactoryGirl.create(:message, :sender => message_sender, :recipient => message_recipient)

        read_message = FactoryGirl.create(:message, :sender => message_sender, :recipient => message_recipient)
        read_message.mark_as_read_by(message_recipient)


        readable_message =   FactoryGirl.create(:message, :sender => message_sender, :recipient => message_recipient)

        parent_message =   FactoryGirl.create(:message, :sender => message_sender, :recipient => message_recipient, :body => 'This is the parent')

        child_message =   FactoryGirl.create(:message, :sender => message_recipient, :recipient => message_sender, :parent => parent_message )

        trash_by_sender_message = FactoryGirl.create(:message, :sender => message_sender, :recipient => message_recipient)
        trash_by_sender_message.move_to_trash(message_sender)


        trash_by_recipient_message = FactoryGirl.create(:message, :sender => message_sender, :recipient => message_recipient)
        trash_by_recipient_message.move_to_trash(message_recipient)


        trash_by_sender_reversed_message =FactoryGirl.create(:message, :sender => message_recipient, :recipient => message_sender)
        trash_by_sender_reversed_message.move_to_trash(message_sender)


        trash_by_recipient_reversed_message =FactoryGirl.create(:message, :sender => message_recipient, :recipient => message_sender)
        trash_by_recipient_reversed_message.move_to_trash(message_recipient)


        unsaved_note =   FactoryGirl.build(:message, :sender => message_sender, :recipient => message_recipient)
        unsaved_note_to_self =   FactoryGirl.build(:message, :sender => message_sender, :recipient => message_sender)
      end
    end
  end
end