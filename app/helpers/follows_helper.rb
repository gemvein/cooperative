module FollowsHelper
  def follows_auto_complete(selector, source)
    html = ""
    html << render(:partial => 'follows/auto_complete', :locals => {:selector => selector, :source => source})
    html.html_safe
  end
end
