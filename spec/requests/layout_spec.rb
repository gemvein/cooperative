require 'spec_helper'

describe "Layout" do
  include_context 'load site'
  include RSpec::Rails::RequestExampleGroup
  it "looks like a bootstrap layout" do
    get '/'
    assert_select '.navbar', 1
    assert_select '.container', :minimum => 1
  end
  
  it "shows the configured application name" do
    get '/'
    assert_select '.brand', Cooperative.configuration.application_name
  end
  
  it "shows the appropriate page links" do
    visit cooperative.home_path
    click_link "About Us"
    click_link "Privacy Policy"
    click_link "Terms of Use"
    click_link "Contact Us"
    click_link "Home"
  end
  
  it "shows child links on their parent pages only" do
    parent_page = FactoryGirl.create(:page, :title => 'Parent Page')
    child_page = FactoryGirl.create(:page, :title => 'Child Page', :parent_id => parent_page.id)
    visit parent_page.path
    page.should have_selector '.well li a', :text => 'Child Page'
    click_link 'Child Page'
    page.should have_selector '.breadcrumb li a', :text => 'Parent Page'
    click_link 'Parent Page'
    click_link 'Home'
    page.should_not have_selector '.nav li a', :text => 'Child Page'
  end
end
