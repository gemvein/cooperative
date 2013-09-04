module MessagesHelper
  def messages_form_for_activities
    @message = Message.new
    render(:partial => 'messages/form_for_activities')
  end
end
