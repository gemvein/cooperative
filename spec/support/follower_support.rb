shared_context 'follower support' do
  let!(:unfollowed_user) { FactoryGirl.create(:user, :public => false) }
  let!(:followed_user) { FactoryGirl.create(:user, :public => false) }
  let!(:follower_user) {
    user = FactoryGirl.create(:user, :public => false)
    user.follow(followed_user)
    user
  }
  let!(:blockable_user) {
    user = FactoryGirl.create(:user, :public => false)
    user.follow(followed_user)
    user
  }
  let!(:blocked_user) {
    user = FactoryGirl.create(:user, :public => false)
    user.follow(followed_user)
    followed_user.block(user)
    user
  }
end