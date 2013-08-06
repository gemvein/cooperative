class GroupsController < ApplicationController
  load_and_authorize_resource
  
  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(params[:group])

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
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to cooperative.group_url(@group), :notice => 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @group.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # GET /groups/1/join
  def join
    @group = Group.find(params[:id])
    current_user.is_member_of @group
  end
  
  # GET /groups/1/leave
  def leave
    @group = Group.find(params[:id])
    @role = Role.where(:name => 'member', :authorizable_type => 'Group', :authorizable_id => @group)
    current_user.roles.delete(@role)
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end
end
