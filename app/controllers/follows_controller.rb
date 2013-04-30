class FollowsController < ApplicationController
 
  def create
    @person = User.find_by_nickname(params[:person_id])
    current_user.follow(@person)
  end
 
  def destroy
    @person = User.find_by_nickname(params[:person_id])
    current_user.stop_following(@person)
  end
 
end