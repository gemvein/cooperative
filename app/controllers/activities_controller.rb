class ActivitiesController < CooperativeController
  before_filter :authenticate_user!
  def index
    notify_user_of = []
    notify_user_of << current_user
    for user in current_user.following_users
      notify_user_of << user
    end

    @activities = Activity.where("(owner_id IN (?) AND owner_type = 'User') OR (recipient_id IN (?) AND recipient_type = 'User')", notify_user_of, notify_user_of).order('created_at DESC').page(params[:page])

    @status = Status.new
    @message = Message.new
  end
end