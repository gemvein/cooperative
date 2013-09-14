module PeopleHelper
  def people_auto_complete(selector)
    # TODO Rewrite this to use AJAX
    @people_nicknames = []
    for person in User.all
      @people_nicknames << person.nickname
    end
    render(:partial => 'people/auto_complete', :locals => {:selector => selector})
  end
end
