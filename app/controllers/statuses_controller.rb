class StatusesController < ApplicationController
  load_and_authorize_resource

  # GET /statuses/new
  # GET /statuses/new.js
  def new
    @status = Status.new
    @share = Share.new
  end

  # POST /statuses
  # POST /statuses.json
  def create
    @status = Status.new(params[:status])
    @status.user = current_user
    @status.save
    @activity = @status.activities.first
    @share = Share.new
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @status = Status.find(params[:id])
    @activity = @status.activities.first
    @status.destroy
  end
end
