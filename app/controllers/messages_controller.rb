class MessagesController < CooperativeController
  before_action :authenticate_user!
  add_breadcrumb :inbox.l, '/messages'

  # GET /messages
  # GET /messages.json
  def index
    @messages = current_user.messages.threads.order('created_at').page(params[:page])
    
    respond_to do |format|
      format.html # index.html.haml
      format.json { render :json => @messages }
    end
  end
  
  # GET /messages/sent
  # GET /messages/sent.json
  def sent
    @messages = current_user.messages_as_sender.threads.order('created_at').page(params[:page])
    add_breadcrumb :sent.l, cooperative.sent_messages_path
    
    respond_to do |format|
      format.html # index.html.haml
      format.json { render :json => @messages }
    end
  end
  
  # GET /messages/trash
  # GET /messages/trash.json
  def trash
    @messages = current_user.message_trash.threads.order('created_at').page(params[:page])
    
    respond_to do |format|
      format.html # index.html.haml
      format.json { render :json => @messages }
    end
  end
  
  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])
    authorize! :show, @message
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
    if @message.invalid?
      render :action => @message.parent ? "reply":"new"
      return
    end
    if current_user.cannot? :message, @message.recipient
      flash['error'] = :messaging_that_user_not_permitted.l
      render :action => @message.parent ? "reply":"new"
      return
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
    @message.parent = Message.find_by_id(params[:id]) || ( not_found and return )
    @message.recipient = @message.parent.sender
    authorize! :reply, @message.parent
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
    authorize! :move, @message

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
    authorize! :move, @message

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