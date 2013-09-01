shared_context 'follower support' do
  let(:followed_user) { FactoryGirl.create(:user) }
  let(:follower_user) {
    user = FactoryGirl.create(:user)
    user.follow(followed_user)
    user
  }
end