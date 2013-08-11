class TagsController < CooperativeController
  add_breadcrumb :tags.l, '/tags'
  
  def index
    @tags = Tag.all
    
    respond_to do |format|
      format.html # index.html.haml
      format.json { render :json => @tags }
    end
  end

  def show
    @tag = Tag.find_by_name(params[:id])
    add_breadcrumb @tag.name, cooperative.tag_path(@tag)
    
    respond_to do |format|
      format.html # show.html.haml
      format.json { render :json => @tag }
    end
  end
end
