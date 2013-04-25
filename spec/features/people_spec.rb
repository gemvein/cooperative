require 'spec_helper'

describe "People" do
  include_context 'load site'
  include_context 'login request'
  before(:each) do
    FactoryGirl.create(:user, :public => true)
    FactoryGirl.create(:user, :public => true)
    FactoryGirl.create(:user, :public => true)
    FactoryGirl.create(:user, :public => true)
    FactoryGirl.create(:user, :public => true)
    FactoryGirl.create(:user, :public => false, :nickname => 'private')
  end
  
  it "has a link in the navbar" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    visit cooperative.home_path
    click_link :people.l
  end
  
  it "has a list of public people" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    visit cooperative.people_path
    page.should have_selector '.person', :minimum => 5
    page.should_not have_selector '.person', :text => 'private'
  end
  
  it "shows individual users" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    person = User.find_all_by_public(true).first
    visit cooperative.person_path(person)
    page.should have_selector 'h1', :text => person.nickname
    page.should have_selector '.container', :exact => person.bio
  end
  
end
