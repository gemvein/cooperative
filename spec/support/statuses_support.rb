module StatusesContext
  extend RSpec::SharedContext

  before :each do
    include Cooperative::SharedUserContexts::BasicUserContext
    public_status =   FactoryGirl.create(:status, :user => public_user)
    unshared_status =   FactoryGirl.create(:status, :user => followed_user)
    shared_status =   FactoryGirl.create(:status, :user => followed_user)
    sharing_status =   FactoryGirl.create(:status, :user => followed_user, :shareable => shared_status)
    imaged_status =   FactoryGirl.create(:status, :user => followed_user, :image_remote_url => 'http://i1.ytimg.com/vi/dQw4w9WgXcQ/hqdefault.jpg')
    tagged_status =   FactoryGirl.create(:status, :user => followed_user, :body => 'not all of #these #are #tags')
    mentioning_status =   FactoryGirl.create(:status, :user => followed_user, :body => "@#followed_user.nickname mentions @#ActivitiesContext.follower_user.nickname")
  end
end