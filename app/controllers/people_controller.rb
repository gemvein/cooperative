class PeopleController < CooperativeController
  add_breadcrumb :people.l, '/people'
  
  def index
    @people = User.where({:public => true}).order(:nickname).page(params[:page])
    
    respond_to do |format|
      format.html # index.html.haml
      format.json { render :json => @people }
    end
  end

  def show
    @person = User.where({:public => true}).find_by_nickname(params[:id])
    add_breadcrumb @person.nickname, cooperative.person_path(@person)

    respond_to do |format|
      format.html # show.html.haml
      format.json { render :json => @person }
    end
  end

  def mini
    @person = User.where({:public => true}).find_by_nickname(params[:id])

    respond_to do |format|
      format.html { render :layout => 'partial' }
    end
  end

end
