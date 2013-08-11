require 'spec_helper'

describe "Groups" do
  include_context "groups support"
  include_context "login support for requests"
  it "shows individual groups" do
    sign_in(@group_joiner)
    visit cooperative.group_path(@public_groups.first)

    current_url.should eq cooperative.group_url(@public_groups.first)
    
    page.should have_selector 'h1', :text => @public_groups.first.name
    page.should have_selector '.container', :text => @public_groups.first.description
  end
  it "shows the index page" do
    sign_in(@group_joiner)
    visit cooperative.groups_path
    current_url.should == cooperative.groups_url
    page.should have_selector 'h1', :text => 'Groups'
  end
end
