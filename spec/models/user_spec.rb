require 'spec_helper'

describe User do
  # Check that gems are installed
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
  it { should have_many(:messages) }
  it { should have_many(:pages) }
  it { should have_many(:statuses) }

  context 'Instance Methods' do

    describe '#show_me' do
      include_context 'follower support'
      subject { follower_user.show_me }
      it { should have_exactly(2).items }
      it { should include follower_user.id }
      it { should include followed_user.id }
    end

    describe '#activities' do
      include_context 'activities support'
      subject { followed_user.activities }
      it { should have_at_least(5).items }
      it { should include created_page_activity }
      it { should include edited_page_activity }
      it { should include deleted_page_activity }
      it { should include owned_status_activity }
      it { should_not include followed_status_activity }
      it { should include mentioned_in_status_activity }
    end

    describe '#activities_as_follower' do
      include_context 'activities support'
      subject { follower_user.activities_as_follower }
      it { should have_at_least(5).items }
      it { should include created_page_activity }
      it { should include edited_page_activity }
      it { should include deleted_page_activity }
      it { should include owned_status_activity }
      it { should include followed_status_activity }
      it { should include mentioned_in_status_activity }
    end

    describe '#ability' do
      include_context 'follower support'
      subject { followed_user.ability }
      it { should be_an Ability }
    end
  end

end