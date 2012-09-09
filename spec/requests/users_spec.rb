require 'spec_helper'

describe "Users" do
  it "has a login page that looks like the rest of the site" do
    get new_user_session_path
    assert_select ".navbar", 1
    assert_select ".container" do
      assert_select "h1", :sign_in.l
      assert_select ".form .control-group .controls #user_email", 1
      assert_select ".form .control-group .controls #user_password", 1
    end
  end
  
  it "requires that the user be a real user" do
    visit new_user_session_path
    fill_in "Email", :with => "bogus@example.com"
    fill_in "Password", :with => "not-the-password"
    click_button :sign_in.l
    current_url.should match '/users/sign_in/?'
    assert_select '.alert-warning', 1
  end
  
  pending "allows signup" do
    
  end
  
  pending "provides access to real users" do
    
  end
  
  pending "has a signup page that looks like the rest of the site"
end
