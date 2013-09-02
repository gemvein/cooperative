shared_context 'statuses support' do
  include_context 'follower support'

  let!(:unshared_status) { FactoryGirl.create(:status, :user => followed_user) }
  let!(:shared_status) { FactoryGirl.create(:status, :user => followed_user) }
  let!(:sharing_status) { FactoryGirl.create(:status, :user => followed_user, :shareable => shared_status) }
  let!(:imaged_status) { FactoryGirl.create(:status, :user => followed_user, :image_remote_url => 'http://i1.ytimg.com/vi/dQw4w9WgXcQ/hqdefault.jpg') }
  let!(:tagged_status) { FactoryGirl.create(:status, :user => followed_user, :body => 'not all of #these #are #tags') }
  let!(:mentioning_status) { FactoryGirl.create(:status, :user => followed_user, :body => "@#{followed_user.nickname} mentions @#{follower_user.nickname}") }
end