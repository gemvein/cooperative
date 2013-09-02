class PeopleController < CooperativeController
  add_breadcrumb :people.l, '/people'
  load_and_authorize_resource

  # GET /people
  # GET /people.json
  def index
    @people = User.where({:public => true}).order(:nickname).page(params[:page])
    
    respond_to do |format|
      format.html # index.html.haml
      format.json { render :json => @people }
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = User.find_by_nickname(params[:id])
    add_breadcrumb @person.nickname, cooperative.person_path(@person)

    respond_to do |format|
      format.html # show.html.haml
      format.json { render :json => @person }
    end
  end
end
