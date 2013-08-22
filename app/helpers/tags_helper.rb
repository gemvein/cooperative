module TagsHelper
  include ActsAsTaggableOn::TagsHelper
  
  def tag_list(tags)
    tag_links = []
    for tag in tags
      tag_links << '<a href="' + cooperative.tag_path(tag.name)  + '">' + tag.name + '</a>' 
    end
    html = ""
    html << render(:partial => 'tags/tag_list', :locals => {:tag_links => tag_links})
    html.html_safe
  end

  def tags_auto_complete(selector, source)
    html = ""
    html << render(:partial => 'tags/auto_complete', :locals => {:selector => selector, :source => source})
    html.html_safe
  end
end
