require 'spec_helper'

describe "Layout" do
  include_context "pages support"
  it "looks like a bootstrap layout" do
    visit '/'
    page.should have_selector '.navbar', :count => 1
    page.should have_selector '.container', :minimum => 1
  end

  it "shows the configured application name" do
    visit '/'
    page.should have_selector '.brand', :text => Cooperative.configuration.application_name
  end

  it "shows the appropriate page links" do
    visit cooperative.home_path
    find('.nav-pills').click_link "About Us"
    find('.nav-pills').click_link "Privacy Policy"
    find('.nav-pills').click_link "Terms of Use"
    find('.nav-pills').click_link "Contact Us"
    find('.nav-pills').click_link "Home"
  end

  it "shows child links on their parent pages only" do
    parent_page = FactoryGirl.create(:page, :title => 'Parent Page')
    child_page = FactoryGirl.create(:page, :title => 'Child Page', :parent_id => parent_page.id)
    visit parent_page.path
    page.should have_selector '.well li a', :text => 'Child Page'
    find('.well').click_link 'Child Page'
    page.should have_selector '.breadcrumb li a', :text => 'Parent Page'
    find('.breadcrumb').click_link 'Parent Page'
    find('.nav-pills').click_link 'Home'
    page.should_not have_selector '.nav li a', :text => 'Child Page'
  end
end
