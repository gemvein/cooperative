shared_context "groups support" do
  before(:each) do
    @group_owner = FactoryGirl.create(:user)
    @public_groups = []
    3.times do 
      @public_groups << FactoryGirl.create(:group)
    end
    @hidden_group = FactoryGirl.create(:group, :public => false)
    
    for group in Group.all
      @group_owner.is_owner_of group
    end
  end
end
