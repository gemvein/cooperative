class PagesController < CooperativeController

  # GET /pages/path or /people/nickname/pages/path
  # GET /pages/path.json or /people/nickname/pages/path.json
  def show
    @pageable = polymorphic_object
    if @pageable.nil?
      @page = Page.find_all_root_pages.find_by_path(params[:path]) || ( not_found and return )
    else
      @page = @pageable.pages.find_by_path(params[:path]) || ( not_found and return )
      case polymorphic_resource
      when 'people'
        add_breadcrumb @pageable.nickname, cooperative.person_path(@pageable)
      else
        add_breadcrumb @pageable.name, polymorphic_path([cooperative, @pageable])
      end
    end
    authorize! :show, @page

    unless @page.ancestry.empty?
      for page in @page.ancestry
        add_breadcrumb page.title, page.path
      end
    end
    add_breadcrumb @page.title, @page.path
    
    respond_to do |format|
      format.html # show.html.haml
      format.json { render :json => @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @pageable_resource = polymorphic_resource
    @pageable = polymorphic_parent
    @page = @pageable.pages.new
    authorize! :create, @page

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @pageable = polymorphic_parent
    @page = polymorphic_parent.pages.find(params[:id])
    authorize! :update, @page

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @page }
    end
  end

  # POST /pages
  # POST /pages.json
  def create
    @pageable = polymorphic_parent
    @page = polymorphic_parent.pages.new(params[:page])
    authorize! :create, @page

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page.path, :notice => 'Page was successfully created.' }
        format.json { render :json => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.json { render :json => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @pageable = polymorphic_parent
    @page = polymorphic_parent.pages.find(params[:id])
    authorize! :update, @page

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page.path, :notice => 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @pageable = polymorphic_parent
    @page = polymorphic_parent.pages.find(params[:id])
    authorize! :destroy, @page
    @page.destroy

    respond_to do |format|
      format.html { redirect_to cooperative.person_pages_path(current_user) }
      format.json { head :no_content }
    end
  end
end
