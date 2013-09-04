class ActivitiesController < CooperativeController
  load_and_authorize_resource

  add_breadcrumb :activities.l, '/activities'

  # GET /activities
  def index
    @activities = current_user.activities_as_follower.order('created_at DESC').page(params[:page])

    respond_to do |format|
      format.html # index.html.haml
      format.json { render :json => @activities }
    end
  end
end