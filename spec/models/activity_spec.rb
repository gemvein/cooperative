require 'spec_helper'

describe Activity do
  # Check that gems are installed
  # Public Activity gem
  it { should belong_to :owner }
  it { should belong_to :recipient }
  it { should belong_to :trackable }

  context 'Class Methods' do
    describe '#find_all_by_users' do
      context 'when full' do
        include_context 'activities support'
        subject { Activity.find_all_by_users([followed_user, follower_user]) }
        it { should have_exactly(9).items }
        it { should include created_page_activity }
        it { should include edited_page_activity }
        it { should include deleted_page_activity }
        it { should include owned_status_activity }
        it { should include followed_status_activity }
        it { should include mentioned_in_status_activity }
      end

      context 'when empty' do
        include_context 'follower support'
        subject { Activity.find_all_by_users([followed_user, follower_user]).empty? }
        it { should be true }
      end

    end
  end
end