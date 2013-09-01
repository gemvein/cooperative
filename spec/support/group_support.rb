shared_context 'group support' do

  let!(:public_group) { FactoryGirl.create(:group, :public => true) }

  let!(:private_group) { FactoryGirl.create(:group, :public => false) }

end
