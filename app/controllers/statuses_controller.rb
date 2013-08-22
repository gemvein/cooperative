class StatusesController < ApplicationController
  load_and_authorize_resource
  
  # GET /statuses/1
  def show
    @status = Status.find_by_id(params[:id])
    
    respond_to do |format|
      format.html # show.html.haml
    end
  end

  # GET /statuses/new
  def new
    @status = Status.new
    if(!params[:status_id].nil?)
      @status.shareable = Status.find_by_id(params[:status_id])
      @status.url = cooperative.status_url(@status.shareable.id)
      @status.title = @status.shareable.title
      @status.description = @status.shareable.description.present? ? @status.shareable.description : @status.shareable.body
      if !@status.shareable.image_file_name.nil?
        @status.image_remote_url = URI::join('http://' + request.host_with_port, @status.shareable.image.url).to_s
      end
    elsif(!params[:url].nil? && params[:url].length > 7)
      @status.url = URI.unescape(params[:url])
    end
    
    respond_to do |format|
      format.html { render :layout => 'partial' }
    end
  end

  # POST /statuses.js
  def create
    @status = Status.new(params[:status])
    @status.user = current_user

    @status.tag_list = @status.body.gsub /^[^#]*\s?#([^\s]+)\s?[^#]*/, '\1,'

    respond_to do |format|
      if @status.save
        @activity = @status.activities.first
        if(!params[:mentions].nil?)
          for mention in params[:mentions]
            @status.create_activity(:mentioned_in, :owner => current_user, :recipient => User.find_by_nickname(mention))
          end
        end
        format.js
      else
        format.js { render :action => 'new' }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @status = Status.find(params[:id])
    @activity = @status.activities.first
    @status.destroy
    respond_to do |format|
      format.js
    end
  end
  
  # GET /statuses/grab.js
  def grab
    @uri = URI.unescape(params[:uri])
    begin
      file = open(@uri)
    rescue
      return
    end
    doc = Nokogiri::HTML(file)
    @title = doc.xpath('//title').first.content
    @description = doc.xpath('//p').text
    # get the images
    @images = []
    doc.css('img').each do |img|
      image_uri = img["src"]
      image_src = URI::join(@uri, image_uri).to_s
      image_size = _get_image_size(image_src)
      @images << {:src => image_src, :size => image_size}
    end
    @images.sort!{|k,l|l[:size] <=> k[:size]}
    @images.compact!
    respond_to do |format|
      format.js
    end
  end
  
  private
  
    def _get_image_size(url)
      uri = URI(url)
      Net::HTTP.start(uri.host, uri.port) do |http|
          # Send a HEAD requesti
          response = http.head(uri.path)
        
          # Get the Content-Length header from response['Your-Header-Here']
          len = response['Content-Length'].to_i
      end
    end
end
