require 'spec_helper'

describe "Admin" do

  it "requires login" do
    get rails_admin.dashboard_path
    response.should redirect_to new_user_session_path
  end
  
  it "does not provide access to dashboard to non-admin users" do
    user = FactoryGirl.create(:user)
    user.save
    # Note that the user is not an admin at this point.
    
    visit new_user_session_path
    
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button :sign_in.l
    
    visit rails_admin.dashboard_path
    current_url.should == cooperative.home_url
    assert_select '.alert-warning', 1
  end
  
  it "provides access to dashboard to admin users" do
    user = FactoryGirl.create(:user)
    user.save
    user.is_admin
    # Note that the user is now an admin
    
    visit new_user_session_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button :sign_in.l
    
    visit rails_admin.dashboard_path
    current_url.should == rails_admin.dashboard_path
    assert_select '.navbar', 1
  end
  
  it "provides access to pages" do
    user = FactoryGirl.create(:user)
    user.save
    user.is_admin
    # Note that the user is now an admin
    
    visit new_user_session_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button :sign_in.l
    
    visit rails_admin.dashboard_path
    click_link "Pages"
  end
  
  it "provides access to users" do
    user = FactoryGirl.create(:user)
    user.save
    user.is_admin
    # Note that the user is now an admin
    
    visit new_user_session_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button :sign_in.l
    
    visit rails_admin.dashboard_path
    click_link "Users"
  end
  
  it "uses base configuration from cooperative" do
    user = FactoryGirl.create(:user)
    user.save
    user.is_admin
    # Note that the user is now an admin
    
    visit new_user_session_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button :sign_in.l
    
    visit rails_admin.dashboard_path
    assert_select '.brand', /^#{Cooperative.configuration.application_name}/
  end
end
