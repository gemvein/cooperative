class CommentsController < CooperativeController

  load_and_authorize_resource :except => :show

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    if can?('access', @comment)
      respond_to do |format|
        format.html # show.html.erb
        format.json { render :json => @comment }
      end
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

    respond_to do |format|
      if @comment.save
        format.js
      else
        format.js
      end
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