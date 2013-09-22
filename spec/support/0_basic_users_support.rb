module BasicUsersContext
  def self.included(base)
    base.class_eval do
      extend RSpec::SharedContext
      before :each do
        unfollowed_user= FactoryGirl.create(:user)
        for permission in unfollowed_user.permissions_as_permissor
          permission.update_attribute :relationship_type, 'none'
        end
        public_user = FactoryGirl.create(:user)
        for permission in public_user.permissions_as_permissor
          permission.update_attribute :relationship_type, 'public'
        end

        followed_user = FactoryGirl.create(:user)
        for permission in followed_user.permissions_as_permissor
          permission.update_attribute :relationship_type, 'user_followers'
        end

        follower_user =FactoryGirl.create(:user)
        follower_user.follow(followed_user)

        blockable_user = FactoryGirl.create(:user)
        blockable_user.follow(followed_user)

        blocked_user = FactoryGirl.create(:user)
        blocked_user.follow(followed_user)
        followed_user.block(blocked_user)
      end
    end
  end
end