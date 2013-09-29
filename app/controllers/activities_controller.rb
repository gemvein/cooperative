class ActivitiesController < CooperativeController
  before_filter :authenticate_user!

  # Don't be a shmoe like this: We're scoping it our own way and we don't want to do it the cancan way this time.
  # load_and_authorize_resource

  add_breadcrumb :activities.l, '/activities'

  # GET /activities
  def index
    @activities = ChalkDust.activity_feed_for(current_user).order('created_at DESC').page(params[:page])

    respond_to do |format|
      format.html # index.html.haml
      format.json { render :json => @activities }
    end
  end
end