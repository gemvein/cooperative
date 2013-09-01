require 'spec_helper'

describe Activity do
  it { should belong_to :owner }
  it { should belong_to :recipient }
  it { should belong_to :trackable }

  describe '#find_all_by_users' do
    include_context 'activities support'

    context 'when valid' do
      subject { Activity.find_all_by_users(follower_user.show_me) }
      #it { should have_at_least(5).items }
    end

  end
end