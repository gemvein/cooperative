shared_context "activities support" do
  before(:each) do
    @following_user = FactoryGirl.create(:user, :public => false)
    @followed_user = FactoryGirl.create(:user, :public => false)
    @following_user.follows @followed_user
    @followed_user.pages << FactoryGirl.create(:page, :title => 'Created Page')
    @followed_user.pages << FactoryGirl.create(:page, :title => 'Created Page 2')
    @followed_user.pages.last.title = 'Edited Page'
    @followed_user.pages.last.save
    @followed_user.pages << FactoryGirl.create(:page, :title => 'Deletable Page')
    @followed_user.pages.last.destroy
  end
end