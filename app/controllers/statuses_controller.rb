class StatusesController < ApplicationController
  load_and_authorize_resource

  # POST /statuses
  # POST /statuses.json
  def create
    @status = Status.new(params[:status])
    @status.user = current_user
    @status.save
    @activity = @status.activities.first
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @status = Status.find(params[:id])
    @activity = @status.activities.first
    @status.destroy
  end
end
