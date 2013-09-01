shared_context "pages support" do
  before(:each) do
    @home = FactoryGirl.create(:page, :title => 'Home')
    @about_us = FactoryGirl.create(:page, :title => 'About Us')
    @privacy_policy = FactoryGirl.create(:page, :title => 'Privacy Policy')
    @terms_of_use = FactoryGirl.create(:page, :title => 'Terms of Use')
    @contact_us = FactoryGirl.create(:page, :title => 'Contact Us')
    @root_pages = [@home, @about_us, @privacy_policy, @terms_of_use, @contact_us]

    @page_owner = FactoryGirl.create(:user, :nickname => 'page_owner')
    @personal_home = FactoryGirl.create(:page, :title => 'Home', :pageable_id => @page_owner.id, :pageable_type => 'User')
    @personal_page = FactoryGirl.create(:page, :title => 'Personal Page', :pageable_id => @page_owner.id, :pageable_type => 'User')
  end
end
