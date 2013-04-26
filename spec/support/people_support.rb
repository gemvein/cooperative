shared_context "populate people" do
  before(:each) do
    @public_users = []
    5.times do 
      @public_users << FactoryGirl.create(:user)
    end
    @hidden_users = []
    6.times do 
      @hidden_users << FactoryGirl.create(:user, :public => false)
    end
    @login_user = FactoryGirl.create(:user, :public => false)
  end
end