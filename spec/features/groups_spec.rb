require 'spec_helper'

feature 'Groups' do
  include LoginContext
  include GroupsContext
  describe 'visiting the Index page' do
    before :each do
      sign_in_as group_joiner
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
    before :each do
      sign_in_as group_joiner
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

  describe 'creating a new group' do
    before :each do
      sign_in_as group_joiner
      visit cooperative.groups_path
      click_link :create_a_group.l
    end
    subject { page }
    it_should_behave_like 'a cooperative page', :new_group.l
    describe 'new form' do
      context 'with invalid attributes' do
        before :each do
          click_button :save.l
        end
        it_should_behave_like 'a page with an object error', 'Group'

      end
      context 'with valid attributes' do
        before :each do
          fill_in 'group[name]', :with => 'Groups are Keen'
          fill_in 'group[description]', :with => 'Lorem ipsum dolor sit amet.'
          fill_in 'group[tag_list]', :with => 'tag1, tag2, tag3'
          click_button :save.l
        end
        it_should_behave_like 'a page with an object creation message', 'Group'
      end
    end
  end

  describe 'editing and updating a group' do
    before :each do
      sign_in_as group_owner
      visit cooperative.group_path(owned_group)
      click_link :edit_group.l
    end
    subject { page }
    it_should_behave_like 'a cooperative page', :edit_group.l
    describe 'edit form' do
      context 'with invalid attributes' do
        before :each do
          fill_in 'group[name]', :with => ''
          click_button :save.l
        end
        it_should_behave_like 'a page with an object error', 'Group'

      end
      context 'with valid attributes' do
        before :each do
          fill_in 'group[name]', :with => 'This has been edited.'
          fill_in 'group[description]', :with => 'Lorem ipsum dolor sit amet.'
          fill_in 'group[tag_list]', :with => 'tag1, tag2, tag3'
          click_button :save.l
        end
        it_should_behave_like 'a page with an object update message', 'Group'
      end
    end
  end

  describe 'destroying a group' do
    before :each do
      sign_in_as group_owner
      visit cooperative.group_path(owned_group)
      click_link :delete_group.l
    end
    it_should_behave_like 'a cooperative page', :groups.l
    describe 'destruction' do
      subject { page.all("#group_#{owned_group.id}") }
      it { should be_empty }
    end
  end
end