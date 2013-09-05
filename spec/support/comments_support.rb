shared_context 'comments support' do
  include_context 'activities support'
  let(:owned_comment) { FactoryGirl.create(:comment, :user_id => follower_user.id, :commentable => owned_status) }
  let(:followed_comment) { FactoryGirl.create(:comment, :user_id => followed_user.id, :commentable => owned_status) }
  let(:unfollowed_comment) { FactoryGirl.create(:comment, :user_id => unfollowed_user.id, :commentable => unfollowed_status) }
end