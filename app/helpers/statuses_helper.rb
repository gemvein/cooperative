module StatusesHelper
  def status_format_body(body)
    body = body.gsub /(https?:\/\/[^\s]+\.[a-z\.]{2,6}\/?[^\s]*)/, '<a href="\1">\1</a>'
    body = body.gsub /@([^\s\?\/,;:'"<>]+)/, '@<a href="/people/\1">\1</a>'
    body = body.gsub /#([^\s\?\/,;:'"<>]+)/, '#<a href="/tags/\1">\1</a>'
    html = ""
    html << body
    html.html_safe
  end
end
