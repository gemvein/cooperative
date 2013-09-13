class CommentsController < CooperativeController
  before_filter :authenticate_user!

  # POST /comments
  # POST /comments.json
  def create
    @comment = current_user.comments.new(params[:comment])
    @commentable = @comment.commentable || ( not_found and return )
    authorize! :create, @comment
    @comment.save!

    respond_to do |format|
      format.js
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy

    respond_to do |format|
      format.js
    end
  end
end