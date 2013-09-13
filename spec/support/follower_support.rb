shared_context 'follower support' do
  let!(:unfollowed_user) {
    user = FactoryGirl.create(:user)
    for permission in user.permissions_as_permissor
      permission.update_attribute :relationship_type, 'none'
    end
    user.permissions.reload
    user
  }
  let!(:followed_user) {
    user = FactoryGirl.create(:user)
    for permission in user.permissions_as_permissor
      permission.update_attribute :relationship_type, 'user_followers'
    end
    user.permissions.reload
    user
  }
  let!(:follower_user) {
    user = FactoryGirl.create(:user)
    user.follow(followed_user)
    user
  }
  let!(:blockable_user) {
    user = FactoryGirl.create(:user)
    user.follow(followed_user)
    user
  }
  let!(:blocked_user) {
    user = FactoryGirl.create(:user)
    user.follow(followed_user)
    followed_user.block(user)
    user
  }
end