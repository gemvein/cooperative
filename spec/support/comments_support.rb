module CommentsContext
  extend RSpec::SharedContext
  before :each do
    owned_comment =   FactoryGirl.create(:comment, :user_id => ActivitiesContext.follower_user.id, :commentable => owned_status)
    followed_comment =   FactoryGirl.create(:comment, :user_id => followed_user.id, :commentable => owned_status)
    unfollowed_comment =   FactoryGirl.create(:comment, :user_id => unfollowed_user.id, :commentable => unfollowed_status)

    25.times do
      FactoryGirl.create(:comment, :commentable => flame_war_status, :user_id => followed_user.id)
    end
  end
end