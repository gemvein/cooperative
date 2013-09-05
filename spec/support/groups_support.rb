shared_context 'groups support' do
  let!(:group_owner) { FactoryGirl.create(:user) }
  let!(:group_member) { FactoryGirl.create(:user) }
  let!(:group_joiner) { FactoryGirl.create(:user) }

  let!(:owned_group) {
    group = FactoryGirl.create(:group, :public => true, :owner => group_owner)
    group_owner.has_role 'owner', group
    group_member.has_role 'member', group
    group
  }

  let!(:public_group) { FactoryGirl.create(:group, :public => true) }

  let!(:private_group) { FactoryGirl.create(:group, :public => false) }

end
