require 'spec_helper'

describe User do
  # Check that gems are installed
  # PrivatePerson gem
  it { should respond_to(:is_permitted?) }
  # Paperclip gem
  it { should have_attached_file(:image) }
  # Acts as Follower gem
  it { should have_many(:follows) }
  it { should have_many(:followings) }
  # Acts as Taggable on gem
  it { should have_many(:base_tags).through(:taggings) }
  # Coletivo gem
  it { should respond_to(:rate!) }
  # Public Activity gem
  it { should have_many(:activities_as_owner) }
  # Friendly ID gem
  it { should respond_to(:friendly_id) }
  # Devise gem
  it { should respond_to(:current_password) }
  # Cancan gem
  it { should respond_to(:can?) }
  it { should respond_to(:cannot?) }

  # Check that appropriate fields are accessible
  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:nickname) }
  it { should allow_mass_assignment_of(:password) }
  it { should allow_mass_assignment_of(:password_confirmation) }
  it { should allow_mass_assignment_of(:remember_me) }
  it { should allow_mass_assignment_of(:public) }
  it { should allow_mass_assignment_of(:bio) }
  it { should allow_mass_assignment_of(:image) }
  it { should allow_mass_assignment_of(:skill_list) }
  it { should allow_mass_assignment_of(:interest_list) }
  it { should allow_mass_assignment_of(:hobby_list) }

  # Check that validations are happening properly
  it { should validate_presence_of(:nickname) }

  # Check relationships
  it { should have_many(:comments) }
  it { should have_many(:messages) }
  it { should have_many(:messages_as_sender) }
  it { should have_many(:pages) }
  it { should have_many(:statuses) }

  context 'Instance Methods' do

    describe '#ability' do
      include_context 'follower support'
      subject { followed_user.ability }
      it { should be_an Ability }
    end

    describe '#message_trash' do
      include_context 'messages support'
      subject { message_sender.message_trash }
      it { should have_exactly(2).items }
      it { should include trash_by_sender_message }
      it { should include trash_by_sender_reversed_message }
    end
  end

end