module StatusesContext
  def self.included(base)
    base.class_eval do
      extend RSpec::SharedContext

      before :each do
        include Cooperative::SharedContexts::BasicUserContext
        public_status =   FactoryGirl.create(:status, :user => public_user)
        unshared_status =   FactoryGirl.create(:status, :user => ActivitiesContext.followed_user)
        shared_status =   FactoryGirl.create(:status, :user => ActivitiesContext.followed_user)
        sharing_status =   FactoryGirl.create(:status, :user => ActivitiesContext.followed_user, :shareable => shared_status)
        imaged_status =   FactoryGirl.create(:status, :user => ActivitiesContext.followed_user, :image_remote_url => 'http://i1.ytimg.com/vi/dQw4w9WgXcQ/hqdefault.jpg')
        tagged_status =   FactoryGirl.create(:status, :user => ActivitiesContext.followed_user, :body => 'not all of #these #are #tags')
        mentioning_status =   FactoryGirl.create(:status, :user => ActivitiesContext.followed_user, :body => "@#ActivitiesContext.followed_user.nickname mentions @#ActivitiesContext.follower_user.nickname")
      end
    end
  end
end