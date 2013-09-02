class PagesController < CooperativeController
  load_and_authorize_resource

  # GET /pages or /people/nickname/pages
  # GET /pages.json or /people/nickname/pages.json
  def index
    unless params[:person_id].blank?
      @person = User.find_by_nickname(params[:person_id])
      @page = @person.pages.find_by_slug('home') || Page.new
    else
      @page = Page.find_all_root_pages.find_by_slug('home') || Page.new
    end
    
    if @person 
      add_breadcrumb @person.nickname, cooperative.person_path(@person)
      add_breadcrumb :pages.l, cooperative.person_pages_path(@person)
    end

    respond_to do |format|
      format.html # index.html.haml
      format.json { render :json => @page }
    end
  end

  # GET /pages/path or /people/nickname/pages/path
  # GET /pages/path.json or /people/nickname/pages/path.json
  def show
    unless params[:person_id].blank?
      @person = User.find_by_nickname(params[:person_id])
      @page = @person.pages.find_by_path(params[:path]) || not_found
    else
      @page = Page.find_all_root_pages.find_by_path(params[:path]) || not_found
    end 
    
    if @person 
      add_breadcrumb @person.nickname, cooperative.person_path(@person)
      add_breadcrumb :pages.l, cooperative.person_pages_path(@person)
    end
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
    unless params[:person_id].blank?
      @person = User.find_by_nickname(params[:person_id])
    end
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = current_user.pages.find(params[:id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @page }
    end
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])
    @page.pageable = current_user

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
    @page = current_user.pages.find(params[:id])

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
    @page = current_user.pages.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to cooperative.person_pages_path(current_user) }
      format.json { head :no_content }
    end
  end
end
