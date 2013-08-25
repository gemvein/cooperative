module CommentsHelper
  def comments_render(commentable)
    html = ""
    html << render(:partial => 'comments/form', :locals => {:commentable => commentable})
    html << render(:partial => 'comments/comments', :locals => {:comments => commentable.comments})
    html.html_safe
  end
end
