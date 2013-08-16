class NotificationsController < CooperativeController
  before_filter :authenticate_user!
  def index
    notify_user_of = []
    notify_user_of << current_user
    for user in current_user.following_users
      notify_user_of << user
    end

    @activities = PublicActivity::Activity.where(:owner_id => notify_user_of, :owner_type => 'User').order('created_at DESC')

    @status = Status.new
    @share = Share.new
  end
end