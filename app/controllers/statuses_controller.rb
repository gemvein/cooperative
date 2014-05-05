class StatusesController < CooperativeController
  before_filter :only =>[ :create, :new, :update] do
    params[:status] = status_params
  end
  add_breadcrumb :activities.l, '/activities'
  load_and_authorize_resource
  
  # GET /statuses/1
  # @status loaded by cancan
  def show
    add_breadcrumb :status.l, @status.path
    
    respond_to do |format|
      format.html # show.html.haml
    end
  end

  # GET /statuses/new
  # @status loaded by cancan
  def new
    add_breadcrumb :new_status.l, cooperative.new_status_path

    respond_to do |format|
      format.html { render :layout => 'partial' }
    end
  end

  # POST /statuses.js
  # @status loaded by cancan
  def create
    @status.user = current_user
    @status.save!
    respond_to do |format|
      format.js
    end
  end

  # DELETE /statuses/1.js
  # @status loaded by cancan
  def destroy
    @status.destroy!
    respond_to do |format|
      format.js
    end
  end
  
  # GET /statuses/grab.js
  # TODO: Put this elsewhere, it's ugly.  Also find way to prevent it from being abused.
  def grab
    @uri = URI.unescape(params[:uri])
    begin
      !!URI.parse(@uri)
    rescue URI::InvalidURIError
      return
    end

    begin
      file = open(@uri)
    rescue
      render inline: 'bad url, no data'
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
      image_size = _get_http_size(image_src)
      @images << {:src => image_src, :size => image_size}
    end
    @images.sort!{|k,l|l[:size] <=> k[:size]}
    @images.compact!

    # get the videos
    @videos = []
    doc.css('embed').each do |video|
      video_type = video["type"]
      video_uri = video["src"].gsub('autoplay=1', '')
      video_src = URI::join(@uri, video_uri).to_s
      video_size = _get_http_size(video_src)
      @videos << {:src => video_src, :size => video_size, :type => video_type}
    end
    @videos.sort!{|k,l|l[:size] <=> k[:size]}
    @videos.compact!
    respond_to do |format|
      format.js
    end
  end
  
private

  def status_params
    params.require(:status).permit(:body, :url, :title, :description, :image_remote_url, :shareable_id, :shareable_type, :tag_list, :media_url, :media_type)
  end

  def _get_http_size(url)
    uri = URI(url)
    Net::HTTP.start(uri.host, uri.port) do |http|
        # Send a HEAD request
        response = http.head(uri.path)

        # Get the Content-Length header from response['Your-Header-Here']
        len = response['Content-Length'].to_i
    end
  end
end
