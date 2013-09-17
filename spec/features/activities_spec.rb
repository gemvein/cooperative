require 'spec_helper'

feature 'Activities' do
  include_context 'login support'
  include_context 'activities support'
  include_context 'comments support'

  before do
    sign_in_as follower_user or raise 'Sign In Failed.'
    visit cooperative.home_path
    page
  end

  describe 'visiting the Home Page' do
    it_should_behave_like 'a cooperative page', :activities.l
    it_should_behave_like 'a page with a status form', '#new_status_tab', 'activities_top'
    it_should_behave_like 'a page with an infinite scroll area'
  end

  describe 'interacting with' do
    describe 'statuses', :js => true do
      subject { page.statuses }
      it { should have_at_least(5).items }
      it { should be_rateable }
      it { should be_commentable }
    end
  end
end