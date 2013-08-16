class SharesController < ApplicationController

  # GET /shares/new
  # GET /shares/new.js
  def new
    @share = Share.new
    @share.shareable_id = params[:shareable_id]
    @share.shareable_type = params[:shareable_type]
    @share.url = URI.unescape(params[:url])
    render :layout => 'modal'
  end
  
  # POST /shares
  # POST /shares.json
  def create
    @share = Share.new(params[:share])
    @share.user = current_user
    if @share.save
      @activity = @share.activities.first
    else
      render :action => 'new', :status => :unprocessable_entity, :layout => 'modal'
    end
  end
  
  # GET /shares/images.js
  def images
    doc = Nokogiri::HTML(open(URI.unescape(params[:uri])))
    @page_title = doc.xpath('//title')
    # get the images
    @images = []
    doc.css('img').each do |img|
      base_uri = URI.unescape(params[:uri])
      image_uri = img["src"]
      @images << URI::join(base_uri, image_uri)
    end
  end

  # DELETE /shares/1
  # DELETE /shares/1.json
  def destroy
    @share = share.find(params[:id])
    @activity = @share.activities.first
    @share.destroy
  end
end
