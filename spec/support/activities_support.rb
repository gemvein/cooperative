shared_context 'activities support' do
  include_context 'follower support'

  let!(:created_page) { FactoryGirl.create(:page, :title => 'Created Page', :pageable => followed_user) }
  let!(:created_page_activity) { Activity.find(created_page.activities.find_by_key('page.create').id) }

  let!(:edited_page) {
    edited_page = FactoryGirl.create(:page, :title => 'Created Page 2', :pageable => followed_user)
    edited_page.title = 'Edited Page'
    edited_page.save!
    edited_page
  }
  let!(:edited_page_activity) { Activity.find(edited_page.activities.find_by_key('page.update').id) }

  let!(:deleted_page) {
    FactoryGirl.create(:page, :title => 'Deletable Page', :pageable => followed_user)
    .destroy
  }
  let!(:deleted_page_activity) { Activity.find(deleted_page.activities.find_by_key('page.destroy').id) }

  let!(:owned_status) { FactoryGirl.create(:status, :user => follower_user) }
  let!(:owned_status_activity) { Activity.find(owned_status.activities.find_by_key('status.create').id) }

  let!(:followed_status) { FactoryGirl.create(:status, :user => followed_user) }
  let!(:followed_status_activity) { Activity.find(followed_status.activities.find_by_key('status.create').id) }

  let!(:mentioned_in_status) { FactoryGirl.create(:status, :user => followed_user, :body => "This status mentions @#{followed_user.nickname} ") }
  let!(:mentioned_in_status_activity) { Activity.find(mentioned_in_status.activities.find_by_key('status.mentioned_in').id) }

  let!(:unfollowed_status) { FactoryGirl.create(:status, :user => unfollowed_user) }
  let!(:unfollowed_status_activity) { Activity.find(unfollowed_status.activities.find_by_key('status.create').id) }

  let!(:flame_war_status) { FactoryGirl.create(:status, :user => followed_user) }
  let!(:flame_war_status_activity) { Activity.find(flame_war_status.activities.find_by_key('status.create').id) }

  let!(:junk_statuses) {
    25.times do
      FactoryGirl.create(:status, :user => followed_user)
    end
  }

end