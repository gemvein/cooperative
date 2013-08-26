module CommentsHelper
  def comment_parse_comment(comment)
    comment = comment.gsub /(https?:\/\/[^\s]+\.[a-z\.]{2,6}\/?[^\s]*)/, '<a href="\1">\1</a>'
    comment = comment.gsub /@([^\s]+)/, '@<a href="/people/\1">\1</a>'
    comment = comment.gsub /#([^\s]+)/, '#<a href="/tags/\1">\1</a>'
    html = ""
    html << comment
    html.html_safe
  end
end
