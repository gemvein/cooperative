class GroupsController < CooperativeController
  before_filter :authenticate_user!

  load_and_authorize_resource
  
  # GET /groups
  # GET /groups.json
  # @groups is assigned by cancan
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  # @group is assigned by cancan
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  # @group is assigned by cancan
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @group }
    end
  end

  # GET /groups/1/edit
  # GET /groups/1/edit.json
  # @group is assigned by cancan
  def edit
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @group }
    end
  end

  # POST /groups
  # POST /groups.json
  # @group is assigned by cancan
  def create
    respond_to do |format|
      if @group.save
        current_user.has_role 'owner', @group
        format.html { redirect_to cooperative.group_url(@group), :notice => 'Group was successfully created.' }
        format.json { render :json => @group, status: :created, :location => cooperative.group_url(@group) }
      else
        format.html { render :action => "new" }
        format.json { render :json => @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  # @group is assigned by cancan
  def update
    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to cooperative.group_url(@group), :notice => 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => 'edit' }
        format.json { render :json => @group.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # GET /groups/1/join
  # GET /groups/1/join.js
  # @group is assigned by cancan
  def join
    current_user.is_member_of @group

    respond_to do |format|
      format.html { redirect_to cooperative.group_url(@group), :notice => 'You have joined ' + @group.name + '.' }
      format.js { render :action => 'join'}
    end
  end
  
  # GET /groups/1/leave
  # GET /groups/1/leave.js
  # @group is assigned by cancan
  def leave
    @role = Role.where(:name => 'member', :authorizable_type => 'Group', :authorizable_id => @group)
    current_user.roles.delete(@role)

    respond_to do |format|
      format.html { redirect_to cooperative.groups_url, :notice => 'You have left ' + @group.name + '.' }
      format.js { render :action => 'leave'}
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  # @group is assigned by cancan
  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to cooperative.groups_url }
      format.json { head :no_content }
    end
  end
end
