shared_context "statuses support" do
  before(:each) do
    @following_user = FactoryGirl.create(:user, :public => false)
    @followed_user = FactoryGirl.create(:user, :public => false)
    @following_user.follow @followed_user
    @statuses = []
    3.times do
      @statuses << FactoryGirl.create(:status, :user => @followed_user)
    end
  end
end