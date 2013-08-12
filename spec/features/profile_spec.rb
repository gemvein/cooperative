require 'spec_helper'

describe "Profiles" do
  include_context "pages support"
  include_context "login support for requests"

  it "has a link in the navbar" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    visit cooperative.home_path
    click_link :edit_my_profile.l
  end

  it "lets users edit their profile" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    visit cooperative.profile_path
    fill_in "user_bio", :with => '<p>This is the new bio</p>'
    click_button :update.l
    page.should have_selector 'h1', :text => user.nickname
    page.should have_selector '.container', :text => 'This is the new bio'
  end
end
