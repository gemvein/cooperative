module ActivitiesContext
  def self.included(base)
    base.class_eval do
      include BasicUsersContext

      before :each do
        created_page_activity = FactoryGirl.create(:page, :title => 'Created Page', :pageable => ActivitiesContext.followed_user)
        created_page_activity = Activity.find(created_page.activities.find_by_key('page.create').id)

        edited_page = FactoryGirl.create(:page, :title => 'Created Page 2', :pageable => ActivitiesContext.followed_user)
        edited_page.title = 'Edited Page'
        edited_page.save!

        edited_page_activity = Activity.find(edited_page.activities.find_by_key('page.update').id)

        deleted_page = FactoryGirl.create(:page, :title => 'Deletable Page', :pageable => ActivitiesContext.followed_user).destroy

        deleted_page_activity = Activity.find(deleted_page.activities.find_by_key('page.destroy').id)

        owned_status = FactoryGirl.create(:status, :user => ActivitiesContext.follower_user)
        owned_status_activity = Activity.find(owned_status.activities.find_by_key('status.create').id)

        followed_status = FactoryGirl.create(:status, :user => ActivitiesContext.followed_user)
        followed_status_activity = Activity.find(followed_status.activities.find_by_key('status.create').id)

        mentioned_in_status = FactoryGirl.create(:status, :user => ActivitiesContext.followed_user, :body => "This status mentions @#ActivitiesContext.followed_user.nickname ")
        mentioned_in_status_activity = Activity.find(mentioned_in_status.activities.find_by_key('status.mentioned_in').id)

        unfollowed_status = FactoryGirl.create(:status, :user => unActivitiesContext.followed_user)
        unfollowed_status_activity = Activity.find(unfollowed_status.activities.find_by_key('status.create').id)

        flame_war_status = FactoryGirl.create(:status, :user => ActivitiesContext.followed_user)
        flame_war_status_activity = Activity.find(flame_war_status.activities.find_by_key('status.create').id)

        25.times do
          FactoryGirl.create(:status, :user => ActivitiesContext.followed_user)
        end
      end
    end
  end
end