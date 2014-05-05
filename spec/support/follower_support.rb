shared_context 'follower support' do
  let!(:unfollowed_user) { user = FactoryGirl.create(:user) }
  let!(:public_user) { user = FactoryGirl.create(:user) }
  let!(:followed_user) { user = FactoryGirl.create(:user) }
  let!(:follower_user) { user = FactoryGirl.create(:user) }
  before :each do
    for permission in followed_user.permissions_as_permissor
      permission.update_attribute :relationship_type, 'user_followers'
    end
    for permission in public_user.permissions_as_permissor
      permission.update_attribute :relationship_type, 'public'
    end
    for permission in unfollowed_user.permissions_as_permissor
      permission.update_attribute :relationship_type, 'none'
    end
    ChalkDust.subscribe(follower_user, :to => followed_user)
  end
end