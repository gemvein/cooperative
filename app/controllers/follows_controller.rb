class FollowsController < CooperativeController
  before_filter :authenticate_user!

  # GET /people/nickname/follows
  # GET /people/nickname/follows.json
  def index
    @person = User.friendly.find(params[:person_id])
    authorize! :show, @person
    @follows = @person.publishers

    respond_to do |format|
      format.json {
        @formatted_follows = [{:val => '', :meta => ''}]
        for follow in @follows
          @formatted_follows << {:val => follow.nickname, :meta => follow.image.url(:thumb)}
        end
        render :json => @formatted_follows
      }
    end
  end

  # GET /people/nickname/followers
  # GET /people/nickname/followers.json
  def followers
    @person = User.friendly.find(params[:id])
    authorize! :show, @person
    @followers = @person.subscribers

    respond_to do |format|
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
    ChalkDust.subscribe(current_user, :to => @person)

    respond_to do |format|
      format.js
    end
  end

  # DELETE /people/nickname/follows.js
  def destroy
    @person = User.friendly.find(params[:id])
    ChalkDust.unsubscribe(current_user, :from => @person)

    respond_to do |format|
      format.js
    end
  end
 
end