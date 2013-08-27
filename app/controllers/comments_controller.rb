class CommentsController < CooperativeController
  add_breadcrumb :activities.l, '/activities'
  load_and_authorize_resource

  def index
    path = request.fullpath
    parts = path.split '/'
    commentable_type = parts[1]
    klass = commentable_type.classify.constantize
    symbol = (commentable_type.singularize + '_id').to_sym
    @commentable = klass.find(params[symbol])
    @comments = Comment.where(:commentable_id => params[symbol], :commentable_type => commentable_type)


    add_breadcrumb commentable_type.capitalize.singularize, polymorphic_path([cooperative, @commentable])
    add_breadcrumb :comments.l, polymorphic_path([cooperative, @commentable, :comments])

    respond_to do |format|
      format.html # index.html.haml
      format.json { render :json => @comments }
    end
  end

  def show
    @comment = Comment.find(params[:id])
    add_breadcrumb @comment.commentable_type, polymorphic_path([cooperative, @comment.commentable])
    add_breadcrumb :comment.l, polymorphic_path([cooperative, @comment.commentable, @comment])

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