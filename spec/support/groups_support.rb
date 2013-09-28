shared_context 'groups support' do
  let!(:group_owner) { FactoryGirl.create(:user) }
  let!(:group_member) { FactoryGirl.create(:user) }
  let!(:group_joiner) { FactoryGirl.create(:user) }

  let!(:owned_group) { FactoryGirl.create(:group, :public => true) }

  let!(:public_group) { FactoryGirl.create(:group, :public => true, :name => 'Public Group') }

  let!(:private_group) { FactoryGirl.create(:group, :public => false) }

  before :each do
    25.times do
      FactoryGirl.create(:group, :public => true)
    end
    group_owner.add_role :owner, owned_group
    group_member.add_role :member, owned_group
  end

end
