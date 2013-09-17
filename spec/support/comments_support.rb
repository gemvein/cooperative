shared_context 'comments support' do
  include_context 'activities support'
  let(:owned_comment) { FactoryGirl.create(:comment, :user_id => follower_user.id, :commentable => owned_status) }
  let(:followed_comment) { FactoryGirl.create(:comment, :user_id => followed_user.id, :commentable => owned_status) }
  let(:unfollowed_comment) { FactoryGirl.create(:comment, :user_id => unfollowed_user.id, :commentable => unfollowed_status) }

  let!(:junk_comments) {
    25.times do
      FactoryGirl.create(:comment, :commentable => flame_war_status, :user_id => followed_user.id)
    end
  }
end