require 'spec_helper'

feature 'Groups' do
  include_context 'login support'
  include_context 'groups support'

  before do
    sign_in_as group_joiner or raise 'Sign In Failed.'
  end

  describe 'visiting the Index page' do
    before do
      visit cooperative.groups_path
    end
    subject { page }
    it_should_behave_like 'a cooperative page', :groups.l
    it_should_behave_like 'a page with a pager'
    describe 'groups', :js => true do
      subject { page.groups }
      it { should have_at_least(5).items }
    end
  end

  describe 'visiting the Show page' do
    before do
      visit cooperative.group_path(public_group)
    end
    subject { page }
    it_should_behave_like 'a cooperative page', 'Public Group'
    describe 'group', :js => true do
      subject { page }
      it { should be_joinable }
      it { should be_leaveable }
    end
  end
end