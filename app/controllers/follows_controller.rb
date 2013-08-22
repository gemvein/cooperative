class FollowsController < ApplicationController

  def index
    @follows = User.find_by_nickname(params[:person_id]).following_users

    respond_to do |format|
      format.html # index.html.haml
      format.json {
        @formatted_follows = [{:val => '', :meta => ''}]
        for follow in @follows
          @formatted_follows << {:val => follow.nickname, :meta => follow.image.url(:thumb)}
        end
        render :json => @formatted_follows
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