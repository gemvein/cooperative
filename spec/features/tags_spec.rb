require 'spec_helper'

describe "Tags" do
  include_context "tags support"
  include_context "people support"
  include_context "login support for requests"
  it "shows individual tags" do
    sign_in(@login_user)
    visit cooperative.tag_path(@foo.name)

    current_url.should eq cooperative.tag_url(@foo.name)
    
    page.should have_selector 'h1', :text => @foo.name
    page.should have_selector 'h2', :text => 'People'
    page.should have_selector 'h2', :text => 'Groups'
    page.should have_selector 'h2', :text => 'Pages'
  end
  it "shows the index page" do
    sign_in(@login_user)
    visit cooperative.tags_path
    current_url.should eq cooperative.tags_url
    page.should have_selector 'h1', :text => 'Tags'
  end
end
