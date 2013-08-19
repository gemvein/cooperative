module StatusesHelper
  def status_format_body(body)
    body = body.gsub /(\s?)(https?:\/\/[^\s]+\.[a-z\.]{2,6}\/?[^\s]*)(\s?)/, '\1<a href="\2">\2</a>\3'
    html = ""
    html << body
    html.html_safe
  end
end
