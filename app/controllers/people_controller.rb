class PeopleController < CooperativeController
  before_filter :authenticate_user!
  add_breadcrumb :people.l, '/people'

  # GET /people
  # GET /people.json
  def index
    @people = User.order(:nickname).page(params[:page])
    
    respond_to do |format|
      format.html # index.html.haml
      format.json { render :json => @people }
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = User.friendly.find(params[:id])
    add_breadcrumb @person.nickname, cooperative.person_path(@person)

    respond_to do |format|
      format.html # show.html.haml
      format.json { render :json => @person }
    end
  end
end
