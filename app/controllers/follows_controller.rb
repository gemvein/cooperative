class FollowsController < CooperativeController

  def index
    @person = User.find_by_nickname(params[:person_id])
    @follows = @person.following_users.order(:nickname).page(params[:page])

    respond_to do |format|
      format.html # index.html.haml
      format.json {
        @formatted_follows = []
        for follow in @follows
          @formatted_follows << {:val => follow.nickname, :meta => follow.image.url(:thumb)}
        end
        render :json => @formatted_follows
      }
    end
  end

  def followers
    @person = User.find_by_nickname(params[:id])
    @followers = Kaminari.paginate_array(@person.followers).page(params[:page])

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
 
  def create
    @person = User.find_by_nickname(params[:person_id])
    current_user.follow(@person)
  end
 
  def destroy
    @person = User.find_by_nickname(params[:person_id])
    current_user.stop_following(@person)
  end
 
end