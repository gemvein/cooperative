class NotificationsController < CooperativeController
  before_filter :authenticate_user!
  def index
    notify_user_of = current_user.following_users
    notify_user_of << current_user.id

    @activities = PublicActivity::Activity.where(owner_id: notify_user_of, owner_type: "User")
    @status = Status.new
  end
end