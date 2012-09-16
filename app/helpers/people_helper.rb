module PeopleHelper
  def people_auto_complete(selector)
    @people_nicknames = []
    for person in User.where({:public => true})
      @people_nicknames << person.nickname
    end
    html = ""
    html << render(:partial => 'people/auto_complete', :locals => {:selector => selector})
    html.html_safe
  end
end
