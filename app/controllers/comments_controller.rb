class CommentsController < CooperativeController
  before_filter :authenticate_user!

  load_and_authorize_resource :comment, :except => [:index, :create]

  add_breadcrumb :activities.l, '/activities'

  # GET /statuses/1/comments
  # GET /statuses/1/comments.json
  # @comments NOT loaded by cancan this time, so we use Comment here.
  def index
    @commentable = polymorphic_parent || ( not_found and return )
    authorize! :comment, @commentable
    @comments = Comment.find_by_commentable(@commentable) || ( not_found and return )

    add_breadcrumb polymorphic_parent_name, polymorphic_path([cooperative, @commentable])
    add_breadcrumb :comments.l, polymorphic_path([cooperative, @commentable, :comments])

    respond_to do |format|
      format.html # index.html.haml
      format.json { render :json => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  # @comment loaded by cancan
  def show
    @commentable = @comment.commentable || ( not_found and return )

    add_breadcrumb polymorphic_parent_name, polymorphic_path([cooperative, @commentable])
    add_breadcrumb :comment.l, cooperative.comment_path(@comment)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @comment }
    end
  end

  # POST /comments
  # POST /comments.json
  # @comment NOT loaded by cancan this time, so we use Comment.new(params[:comment]) here.
  def create
    @comment = Comment.new(params[:comment])
    @commentable = @comment.commentable
    authorize! :comment, @commentable
    @comment.user = current_user
    @comment.save

    respond_to do |format|
      format.js
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  # @comment loaded by cancan
  def destroy
    @comment.destroy

    respond_to do |format|
      format.js
    end
  end
end