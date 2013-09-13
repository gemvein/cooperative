class TagsController < CooperativeController
  load_and_authorize_resource
  add_breadcrumb :tags.l, '/tags'

  # GET /tags
  # GET /tags.json
  # @tags has already been loaded by cancan
  def index
    @tags = @tags.total_item_counts

    @tags.sort_by! {|t| t[:name]}

    respond_to do |format|
      format.html # index.html.haml
      format.json {
        @formatted_tags = [{:val => ''}]
        for tag in @tags
          @formatted_tags << {:val => tag[:name]}
        end
        render :json => @formatted_tags
      }
    end
  end

  # GET /tag/tag-name
  # GET /tag/tag-name.js
  # @tag has already been loaded by cancan
  def show
    add_breadcrumb @tag.name, cooperative.tag_path(@tag)
    
    respond_to do |format|
      format.html # show.html.haml
      format.json { render :json => @tag }
    end
  end
end
