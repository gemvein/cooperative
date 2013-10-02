shared_context 'pages support' do
  let!(:page_owner) {
    user = FactoryGirl.create(:user)
    user.wildcard_permit! 'public', 'Page'
    user
  }
  let!(:page_follower) { FactoryGirl.create(:user) }
  let!(:page_stranger) { FactoryGirl.create(:user) }
  let!(:page_viewer) { FactoryGirl.create(:user) }
  let!(:private_page_owner) { FactoryGirl.create(:user) }

  let!(:root_parent_page) { FactoryGirl.create(:page, :title => 'Parent') }
  let!(:root_child_page) { FactoryGirl.create(:page, :title => 'Child', :parent => root_parent_page) }
  let!(:root_grandchild_page) { FactoryGirl.create(:page, :title => 'Grandchild', :parent => root_child_page) }

  let!(:owned_parent_page) { FactoryGirl.create(:page, :title => 'Parent', :pageable => page_owner) }
  let!(:owned_child_page) { FactoryGirl.create(:page, :title => 'Child', :pageable => page_owner, :parent => owned_parent_page) }
  let!(:owned_grandchild_page) { FactoryGirl.create(:page, :title => 'Grandchild', :pageable => page_owner, :parent => owned_child_page) }

  let!(:private_home_page) { FactoryGirl.create(:page, :title => 'Home', :pageable => private_page_owner) }
  let!(:private_inner_page) { FactoryGirl.create(:page, :title => 'Inner', :pageable => private_page_owner, :parent => private_home_page) }

  before do
    ChalkDust.subscribe(page_follower, :to => page_owner)
    ChalkDust.subscribe(private_page_owner, :to => page_viewer)
  end
end