class RatingsController < ApplicationController
  # GET /statuses/1/rate/5
  def rate
    @rateable = polymorphic_parent_class.find(params[:id])

    if(can? :rate, @rateable)
      current_user.rate! @rateable, params[:rating]
      @rateable.reload
    end

    respond_to do |format|
      format.js { render :action => 'rate'}
    end
  end

  # GET /statuses/1/unrate
  def unrate
    @rateable = polymorphic_parent_class.find(params[:id])

    if(can? :rate, @rateable)
      @rateable.person_ratings.find_all_by_person(current_user).destroy_all
      @rateable.reload
    end

    respond_to do |format|
      format.js { render :action => 'rate'}
    end
  end
end
