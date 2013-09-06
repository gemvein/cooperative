require 'spec_helper'

describe Message do
  # Check that appropriate fields are accessible
  it { should allow_mass_assignment_of(:recipient_id) }
  it { should allow_mass_assignment_of(:recipient_nickname) }
  it { should allow_mass_assignment_of(:sender_id) }
  it { should allow_mass_assignment_of(:parent_id) }
  it { should allow_mass_assignment_of(:body) }

  # Check that validations are happening properly
  it { should validate_presence_of(:recipient_nickname) }
  it { should validate_presence_of(:subject) }
  it { should validate_presence_of(:body) }

  # Check relationships
  it { should belong_to(:sender) }
  it { should belong_to(:recipient) }
  it { should belong_to(:parent) }

  it { should have_many(:children) }

  context 'Class Methods' do
    include_context 'messages support'

    describe '#unread' do
      subject { Message.unread }
      it { should include unread_message }
      it { should_not include read_message }
    end

    describe '#threads' do
      subject { Message.threads }
      it { should include unread_message }
      it { should include read_message }
      it { should include parent_message }
      it { should_not include child_message }
    end

    describe '#sent_by' do
      subject { Message.sent_by(message_sender) }
      it { should include unread_message }
      it { should include read_message }
      it { should include parent_message }
      it { should_not include trash_by_sender_message }
    end

    describe '#received_by' do
      subject { Message.received_by(message_recipient) }
      it { should include unread_message }
      it { should include read_message }
      it { should include parent_message }
      it { should_not include trash_by_recipient_message }
    end

    describe '#trash_by' do
      subject { Message.trash_by(message_sender) }
      it { should_not include unread_message }
      it { should_not include read_message }
      it { should_not include parent_message }
      it { should_not include child_message }
      it { should include trash_by_sender_message }
      it { should include trash_by_sender_reversed_message }
      it { should_not include trash_by_recipient_message }
      it { should_not include trash_by_recipient_reversed_message }
    end
  end

  context 'Instance Methods' do
    include_context 'messages support'

    describe '#you_cant_send_messages_to_yourself' do
      context 'when valid' do
        subject {
          unsaved_note.save
          unsaved_note
        }
        it { should be_valid }
      end
      context 'when invalid' do
        subject {
          unsaved_note_to_self.save
          unsaved_note_to_self
        }
        it { should be_invalid }
      end
    end

    describe '#thread' do
      context 'when self' do
        subject { parent_message.thread }
        it { should be parent_message }
      end

      context 'when parent' do
        subject { child_message.thread }
        it { should be parent_message }
      end

      context 'when absent' do
        subject { unread_message.thread }
        it { should be unread_message }
      end
    end

    describe '#thread_count' do
      context 'when self' do
        subject { parent_message.thread_count }
        it { should be 2 }
      end

      context 'when parent' do
        subject { child_message.thread_count }
        it { should be 1 }
      end

      context 'when absent' do
        subject { unread_message.thread_count }
        it { should be 1 }
      end
    end

    describe '#recipient_nickname' do
      subject { parent_message.recipient_nickname }
      it { should be message_recipient.nickname }
    end

    describe '#recipient_nickname=' do
      subject {
        message = FactoryGirl.create(:message, :sender => message_sender, :recipient_nickname => message_recipient.nickname )
        message.recipient
      }
      it { should eq message_recipient }
    end

    describe '#mark_as_read_by' do
      context 'when sender' do
        subject {
          readable_message.mark_as_read_by(message_sender)
          readable_message.read_at
        }
        it { should_not be_present }

      end
      context 'when recipient' do
        subject {
          readable_message.mark_as_read_by(message_recipient)
          readable_message.read_at
        }
        it { should be_present }
      end
    end

    describe '#read' do
      context 'when sender' do
        subject {
          readable_message.read
          readable_message.read_at
        }
        it { should be_present }
      end
    end

    describe '#unread?' do
      context 'when unread' do
        subject { unread_message.unread?(message_recipient) }
        it { should be true }
      end
      context 'when read' do
        subject { read_message.unread?(message_recipient) }
        it { should be false }
      end
    end

    describe '#with' do
      context 'when sender' do
        subject { unread_message.with(message_sender) }
        it { should be message_recipient }
      end
      context 'when recipient' do
        subject { unread_message.with(message_recipient) }
        it { should be message_sender }
      end
    end

    describe '#move_to_trash' do
      context 'when sender' do
        subject {
          unread_message.move_to_trash(message_sender)
          unread_message.deleted_by_sender
        }
        it { should be_present }
      end
      context 'when recipient' do
        subject {
          unread_message.move_to_trash(message_recipient)
          unread_message.deleted_by_recipient
        }
        it { should be_present }
      end
    end

    describe '#restore' do
      context 'when sender' do
        subject {
          unread_message.move_to_trash(message_sender)
          unread_message.restore(message_sender)
          unread_message.deleted_by_sender
        }
        it { should_not be_present }
      end
      context 'when recipient' do
        subject {
          unread_message.move_to_trash(message_recipient)
          unread_message.restore(message_recipient)
          unread_message.deleted_by_recipient
        }
        it { should_not be_present }
      end
    end

  end

end