class FollowsController < CooperativeController
  before_filter :authenticate_user!

  # GET /people/nickname/follows
  # GET /people/nickname/follows.json
  def index
    @person = User.friendly.find(params[:person_id])
    authorize! :show, @person
    @follows = @person.following_users.order(:nickname).page(params[:page])

    respond_to do |format|
      format.html # index.html.haml
      format.json { render :json => @follows }
    end
  end

  # GET /people/nickname/followers
  # GET /people/nickname/followers.json
  def followers
    @person = User.friendly.find(params[:id])
    authorize! :show, @person
    @followers = BootstrapPager.paginate_array(@person.followers).page(params[:page])

    respond_to do |format|
      format.html # followers.html.haml
      format.json {
        @formatted_followers = [{:val => '', :meta => ''}]
        for follow in @followers
          @formatted_followers << {:val => follow.nickname, :meta => follow.image.url(:thumb)}
        end
        render :json => @formatted_followers
      }
    end
  end

  # POST /people/nickname/follows.js
  def create
    @person = User.friendly.find(params[:person_id])
    current_user.follow(@person)

    respond_to do |format|
      format.js
    end
  end

  # DELETE /people/nickname/follows.js
  def destroy
    @person = User.friendly.find(params[:id])
    current_user.stop_following(@person)

    respond_to do |format|
      format.js
    end
  end
 
end