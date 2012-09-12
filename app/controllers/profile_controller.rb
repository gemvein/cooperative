class ProfileController < CooperativeController
  add_breadcrumb :my_profile.l, '/profile'
  
  # GET /pages/1/edit
  def edit
    @user = current_user
  end
  
  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to cooperative.person_path(@user), :notice => 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @page.errors, :status => :unprocessable_entity }
      end
    end
  end
end
