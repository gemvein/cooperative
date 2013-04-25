require 'spec_helper'

describe "Messages" do
  include_context 'load site'
  include_context 'login request'
  
  it "has a link in the navbar" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    visit cooperative.home_path
    within '.navbar' do
      click_link :inbox.l
    end
    page.should have_selector 'h1', :text => :inbox.l
  end
  
  it "sends messages" do
    visit cooperative.new_message_path
  end
end
