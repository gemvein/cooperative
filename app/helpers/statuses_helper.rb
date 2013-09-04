module StatusesHelper
  def statuses_form_for_activities
    @status = Status.new
    render(:partial => 'statuses/form_for_activities', :locals => {:current_user => @current_user})
  end
end
