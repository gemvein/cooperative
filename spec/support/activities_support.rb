shared_context 'activities support' do
  include_context 'follower support'

  let!(:created_page) { FactoryGirl.create(:page, :title => 'Created Page', :pageable => followed_user) }

  let!(:edited_page) {
    edited_page = FactoryGirl.create(:page, :title => 'Created Page 2', :pageable => followed_user)
    edited_page.title = 'Edited Page'
    edited_page.save!
    edited_page
  }

  let!(:deleted_page) {
    FactoryGirl.create(:page, :title => 'Deletable Page', :pageable => followed_user)
    .destroy
  }

  let!(:owned_status) { FactoryGirl.create(:status, :user => follower_user) }

  let!(:followed_status) { FactoryGirl.create(:status, :user => followed_user) }

  let!(:mentioned_in_status) { FactoryGirl.create(:status, :user => followed_user, :body => "This status mentions @#{followed_user.nickname} ") }

  let!(:unfollowed_status) { FactoryGirl.create(:status, :user => unfollowed_user) }

  let!(:flame_war_status) { FactoryGirl.create(:status, :user => followed_user) }

  before do
    25.times do
      FactoryGirl.create(:status, :user => followed_user)
    end
  end

end