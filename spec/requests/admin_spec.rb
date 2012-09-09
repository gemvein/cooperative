require 'spec_helper'

describe "Admin" do

  it "requires login" do
    get '/admin'
    response.should redirect_to '/users/sign_in'
  end
  
  it "has a login page that looks like the rest of the site" do
    get '/users/sign_in/'
    assert_select ".navbar", 1
    assert_select ".container" do
      assert_select "h1", :sign_in.l
      assert_select ".form .control-group .controls #user_email", 1
      assert_select ".form .control-group .controls #user_password", 1
    end
  end
  
  it "requires that the user be a real user" do
    visit '/users/sign_in/'
    fill_in "Email", :with => "bogus@example.com"
    fill_in "Password", :with => "password"
    click_button :sign_in.l
    current_url.should match '/users/sign_in/?'
    assert_select '.alert-warning', 1
  end
  
  pending "does not provide access to dashboard when cancan says it can't" do
    visit '/users/sign_in/'
  end
  
  pending "provides access to pages"
  pending "provides access to users"
  pending "uses base configuration from cooperative"
end
