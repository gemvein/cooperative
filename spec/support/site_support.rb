shared_context "load site" do
  before(:each) do
    FactoryGirl.create(:page, :title => 'Home')
    FactoryGirl.create(:page, :title => 'About Us')
    FactoryGirl.create(:page, :title => 'Privacy Policy')
    FactoryGirl.create(:page, :title => 'Terms of Use')
    FactoryGirl.create(:page, :title => 'Contact Us')
  end
end
