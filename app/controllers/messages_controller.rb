class MessagesController < CooperativeController
  before_filter :authenticate_user!
  add_breadcrumb :inbox.l, '/messages'
  
  def index
    @messages = Message.threads(Message.where({:recipient_id => current_user.id, :deleted_by_recipient => [false, nil, '', 0]})).order('created_at').page(params[:page])
    
    respond_to do |format|
      format.html # index.html.haml
      format.json { render :json => @messages }
    end
  end
  
  # GET /messages/sent
  # GET /messages/sent.json
  def sent
    @messages = Message.threads(Message.where({:sender_id => current_user.id, :deleted_by_sender => [false, nil, '', 0]})).order('created_at').page(params[:page])
    add_breadcrumb :sent.l, cooperative.sent_messages_path
    
    respond_to do |format|
      format.html # index.html.haml
      format.json { render :json => @messages }
    end
  end
  
  # GET /messages/trash
  # GET /messages/trash.json
  def trash
    @messages = Message.threads(Message.where("(sender_id = ? AND deleted_by_sender = 't') OR (recipient_id = ? AND deleted_by_recipient = 't')", current_user.id, current_user.id)).order('created_at').page(params[:page])
    
    respond_to do |format|
      format.html # index.html.haml
      format.json { render :json => @messages }
    end
  end
  
  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find_by_id(params[:id])
    @message.thread.mark_as_read_by(current_user)
    
    add_breadcrumb @message.thread.subject, cooperative.message_path(@message)
    
    respond_to do |format|
      format.html # show.html.haml
      format.json { render :json => @message }
    end
  end
  
  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new
    add_breadcrumb :compose.l, cooperative.new_message_path   
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @message }
    end
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(params[:message])
    @message.sender = current_user
    if(@message.parent_id)
      @message.parent = Message.find(@message.parent_id)
    end
    add_breadcrumb :compose.l, cooperative.new_message_path   
    
    respond_to do |format|
      if @message.save
        format.html { redirect_to cooperative.message_url(@message), :notice => 'Message was sent.' }
        format.json { render :json => @message, :status => :created, :location => @message }
      else
        format.html { render :action => @message.parent ? "reply":"new" }
        format.json { render :json => @message.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # GET /messages/1/reply
  # GET /messages/1/reply.json
  def reply
    @message = Message.new
    @message.parent = Message.find_by_id(params[:id])
    @message.recipient = @message.parent.sender
    add_breadcrumb @message.thread.subject, cooperative.message_path(@message.parent)
    add_breadcrumb :reply.l, cooperative.reply_message_path(@message.parent)

    respond_to do |format|
      format.html # reply.html.erb
      format.json { render :json => @message }
    end
  end

  # GET /pages/1/trash
  # GET /pages/1/trash.json
  def move_to_trash
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.thread.move_to_trash(current_user)
        format.html { redirect_to cooperative.messages_path, :notice => 'Message was moved to the trash.  You can restore it on the trash page.' }
        format.json { head :no_content }
      else
        format.html { render :action => "show" }
        format.json { render :json => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /messages/1/restore
  # GET /messages/1/restore.json
  def restore
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.thread.restore(current_user)
        format.html { redirect_to cooperative.messages_path, :notice => 'Message was restored.' }
        format.json { head :no_content }
      else
        format.html { render :action => "show" }
        format.json { render :json => @message.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end