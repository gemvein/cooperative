class TagsController < CooperativeController
  add_breadcrumb :tags.l, '/tags'
  
  def index
    #pull out tags with names at least 3 characters long
    @tags = Tag.where("name LIKE '__%'").total_item_counts

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

  def show
    @tag = Tag.find_by_name(params[:id])
    add_breadcrumb @tag.name, cooperative.tag_path(@tag)
    
    respond_to do |format|
      format.html # show.html.haml
      format.json { render :json => @tag }
    end
  end
end
