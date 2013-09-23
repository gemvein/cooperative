module CommentsContext
  def self.included(base)
    base.class_eval do
      extend RSpec::SharedContext
      before :each do
        owned_comment =   FactoryGirl.create(:comment, :user_id => ActivitiesContext.follower_user.id, :commentable => owned_status)
        followed_comment =   FactoryGirl.create(:comment, :user_id => ActivitiesContext.followed_user.id, :commentable => owned_status)
        unfollowed_comment =   FactoryGirl.create(:commeActivitiesContext.followed_user=> unfollowed_user.id, :commentable => unfollowed_status)

        25.times do
          FactoryGirl.create(:comment, :commentabActivitiesContext.followed_userar_status, :user_id => followed_user.id)
        end
      end
    end
  end
end