module PagesContext
  extend RSpec::SharedContext
  before :each do
    page_owner = FactoryGirl.create(:user)
    page_owner.wildcard_permit! 'public', 'Page'

    page_follower =   FactoryGirl.create(:user)
    page_stranger =   FactoryGirl.create(:user)
    page_viewer =   FactoryGirl.create(:user)
    private_page_owner =   FactoryGirl.create(:user)

    root_parent_page =   FactoryGirl.create(:page, :title => 'Parent')
    root_child_page =   FactoryGirl.create(:page, :title => 'Child', :parent => root_parent_page)
    root_grandchild_page =   FactoryGirl.create(:page, :title => 'Grandchild', :parent => root_child_page)

    owned_parent_page =   FactoryGirl.create(:page, :title => 'Parent', :pageable => page_owner)
    owned_child_page =   FactoryGirl.create(:page, :title => 'Child', :pageable => page_owner, :parent => owned_parent_page)
    owned_grandchild_page =   FactoryGirl.create(:page, :title => 'Grandchild', :pageable => page_owner, :parent => owned_child_page)

    private_home_page =   FactoryGirl.create(:page, :title => 'Home', :pageable => private_page_owner)
    private_inner_page =   FactoryGirl.create(:page, :title => 'Inner', :pageable => private_page_owner, :parent => private_home_page)

    page_follower.follow page_owner
    private_page_owner.follow page_viewer
  end
end