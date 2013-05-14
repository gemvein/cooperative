require 'spec_helper'


describe "Users" do
  include_context "login support for requests"
  include_context "pages support"

  it "has a login link" do
    user = FactoryGirl.create(:user)

    visit cooperative.home_path
    find('.navbar').click_link :sign_in.l
    page.should have_selector '#user_email'
    page.should have_selector '#user_password'
  end

  it "has a registration link" do
    user = FactoryGirl.create(:user)

    visit cooperative.home_path
    find('.navbar').click_link :sign_up.l
    page.should have_selector '#user_email'
    page.should have_selector '#user_nickname'
    page.should have_selector '#user_password'
    page.should have_selector '#user_password_confirmation'
  end

  it "has an edit account page" do
    user = FactoryGirl.create(:user)
    sign_in user

    visit cooperative.home_path
    click_link :edit_my_account.l
    page.should have_selector '#user_email'
    page.should_not have_selector '#user_nickname'
    page.should have_selector '#user_password'
    page.should have_selector '#user_password_confirmation'
    page.should have_selector '#user_current_password'
    page.should have_selector '#user_public'
  end

  it "has a login page that looks like the rest of the site" do
    visit new_user_session_path

    page.should have_selector ".navbar", :count => 1
    page.should have_selector ".container" do
      page.should have_selector "h1", :sign_in.l
      page.should have_selector ".form .control-group .controls #user_email", :count => 1
      page.should have_selector ".form .control-group .controls #user_password", :count => 1
    end
  end

  it "requires that the user be a real user" do
    user = FactoryGirl.build(:user)
    # Note that we didn't save the user
    sign_in user
    current_url.should match '/users/sign_in/?'
    page.should have_selector '.alert-warning', :count => 1
  end

  it "has a signup page that looks like the rest of the site" do
    visit new_user_registration_path
    page.should have_selector ".navbar", :count => 1
    page.should have_selector ".container" do
      page.should have_selector "h1", :sign_up.l
      page.should have_selector ".form .control-group .controls #user_email", :count => 1
      page.should have_selector ".form .control-group .controls #user_password", :count => 1
      page.should have_selector ".form .control-group .controls #user_password_confirmation", :count => 1
    end
  end

  it "allows signup" do
    user = FactoryGirl.build(:user)
    count = User.count

    visit new_user_registration_path
    fill_in "user_email", :with => user.email
    fill_in "user_nickname", :with => user.nickname
    fill_in "user_password", :with => user.password
    fill_in "user_password_confirmation", :with => user.password
    click_button :sign_up.l

    User.count.should be count + 1
  end

  it "provides access to real users" do
    user = FactoryGirl.create(:user)
    sign_in user

    page.should have_selector '.alert-info', :text => /Signed in successfully/

  end

  it "has a logout link" do
    user = FactoryGirl.create(:user)
    sign_in user

    find('.navbar').click_link :sign_out.l
    page.should have_selector '.alert-info', :text => /Signed out successfully/
  end
end
