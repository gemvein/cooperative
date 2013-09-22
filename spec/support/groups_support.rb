module GroupsContext
  extend RSpec::SharedContext
  before :each do
    group_owner =   FactoryGirl.create(:user)
    group_member =   FactoryGirl.create(:user)
    group_joiner =   FactoryGirl.create(:user)

    owned_group =   FactoryGirl.create(:group, :public => true)

    public_group =   FactoryGirl.create(:group, :public => true, :name => 'Public Group')

    private_group =   FactoryGirl.create(:group, :public => false)

    25.times do
      FactoryGirl.create(:group, :public => true)
    end
    group_owner.add_role :owner, owned_group
    group_member.add_role :member, owned_group
  end

end
