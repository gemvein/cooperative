shared_context 'messages support' do
  let!(:message_sender) { FactoryGirl.create(:user) }
  let!(:message_recipient) { FactoryGirl.create(:user) }
  let!(:message_nonrecipient) { FactoryGirl.create(:user) }

  let!(:unread_message) { FactoryGirl.create(:message, :sender => message_sender, :recipient => message_recipient)}

  let!(:read_message) {
    message = FactoryGirl.create(:message, :sender => message_sender, :recipient => message_recipient)
    message.mark_as_read_by(message_recipient)
    message
  }

  let!(:readable_message) { FactoryGirl.create(:message, :sender => message_sender, :recipient => message_recipient)}

  let!(:parent_message) { FactoryGirl.create(:message, :sender => message_sender, :recipient => message_recipient, :body => 'This is the parent') }

  let!(:child_message) { FactoryGirl.create(:message, :sender => message_recipient, :recipient => message_sender, :parent => parent_message ) }

  let!(:trash_by_sender_message) {
    message = FactoryGirl.create(:message, :sender => message_sender, :recipient => message_recipient)
    message.move_to_trash(message_sender)
    message
  }

  let!(:trash_by_recipient_message) {
    message = FactoryGirl.create(:message, :sender => message_sender, :recipient => message_recipient)
    message.move_to_trash(message_recipient)
    message
  }

  let!(:trash_by_sender_reversed_message) {
    message = FactoryGirl.create(:message, :sender => message_recipient, :recipient => message_sender)
    message.move_to_trash(message_sender)
    message
  }

  let!(:trash_by_recipient_reversed_message) {
    message = FactoryGirl.create(:message, :sender => message_recipient, :recipient => message_sender)
    message.move_to_trash(message_recipient)
    message
  }

  let!(:unsaved_note) { FactoryGirl.build(:message, :sender => message_sender, :recipient => message_recipient) }
  let!(:unsaved_note_to_self) { FactoryGirl.build(:message, :sender => message_sender, :recipient => message_sender) }

end