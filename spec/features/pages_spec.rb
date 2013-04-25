require 'spec_helper'

describe "Pages" do
  include_context 'load site'
  it "shows pages" do
    my_page = FactoryGirl.create(:page)
    visit my_page.path

    current_url.should match /#{my_page.slug}$/
    page.should have_selector 'h1', :text => my_page.title
    page.should have_title my_page.title + ': ' + Cooperative.configuration.application_name + ': ' + my_page.keywords
    page.should have_selector 'meta[name="keywords"]', :exact => my_page.keywords, :visible => false
    page.should have_selector 'meta[name="description"]', :exact => my_page.description, :visible => false
    page.should have_selector '.container', :exact => my_page.body
  end
  it "shows the homepage by default" do
    visit cooperative.home_path
    current_url.should == cooperative.home_url
    page.should have_selector 'h1', :text => 'Home'
  end
end
