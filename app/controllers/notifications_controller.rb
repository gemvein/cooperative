class NotificationsController < CooperativeController
  before_filter :authenticate_user!
  def index
    @activities = PublicActivity::Activity.where(owner_id: current_user.following_users, owner_type: "User")
  end
end