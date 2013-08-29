class CommentsController < CooperativeController
  add_breadcrumb :activities.l, '/activities'
  load_and_authorize_resource

  def index
    @commentable = polymorphic_parent_class.find(polymorphic_parent_id)
    @comments = Comment.find_by_commentable(@commentable)


    add_breadcrumb polymorphic_parent_name, polymorphic_path([cooperative, @commentable])
    add_breadcrumb :comments.l, polymorphic_path([cooperative, @commentable, :comments])

    respond_to do |format|
      format.html # index.html.haml
      format.json { render :json => @comments }
    end
  end

  def show
    @commentable = polymorphic_parent_class.find(polymorphic_parent_id)
    @comment = Comment.find_by_commentable(@commentable).find(params[:id])
    add_breadcrumb polymorphic_parent_name, polymorphic_path([cooperative, @commentable])
    add_breadcrumb :comment.l, polymorphic_path([cooperative, @commentable, @comment])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @comment }
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @commentable = @comment.commentable
    @comment.save

    respond_to do |format|
      format.js
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to cooperative.comments_url }
      format.json { head :no_content }
    end
  end
end