shared_context 'pages support' do
  let!(:page_owner) { FactoryGirl.create(:user) }

  let!(:root_parent_page) { FactoryGirl.create(:page, :title => 'Parent') }
  let!(:root_child_page) { FactoryGirl.create(:page, :title => 'Child', :parent => root_parent_page) }
  let!(:root_grandchild_page) { FactoryGirl.create(:page, :title => 'Grandchild', :parent => root_child_page) }

  let!(:owned_parent_page) { FactoryGirl.create(:page, :title => 'Parent', :pageable => page_owner) }
  let!(:owned_child_page) { FactoryGirl.create(:page, :title => 'Child', :pageable => page_owner, :parent => owned_parent_page) }
  let!(:owned_grandchild_page) { FactoryGirl.create(:page, :title => 'Grandchild', :pageable => page_owner, :parent => owned_child_page) }
end