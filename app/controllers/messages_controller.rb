class MessagesController < ApplicationController
  before_filter :the_conversation
  before_filter :the_user
  before_filter :the_other_user
  after_filter :create_other_message, :only => [:create]
  
  # GET /messages
  def index
    @messages = Message.where("user_id = ? AND conversation_id = ? ", the_user, the_conversation)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /messages/1
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # Each user has their own conversation in a "has_many" messages relationship. Each set is managed from 
  # their own perspective, thus no internal managing of delete flags and sharing of the same rows.
  # So when a new conversation and/or message is created, a mirrored conversation object
  # is added (with "user" and "other" values flipped) for the other user, along with a mirrored copy
  # of the message object created for the other user (with user_id reset to the other's id)
  # The benefit of this approach is there are no data dependencies among/between users so it's 
  # easy to manage the data programmatically. The management lies independently with each user. They
  # are free to delete conversations (and dependent messages). Furthering a deleted conversation restarts  
  # the thread, showing only new messages. This is same functionality as with Gmail and Facebook internal 
  # messaging.
   
  # GET /messages/new
  def new
    @message = Message.new
    @message.user_id = @conversation.user_id        # who owns this message? this user!
    @message.source_id = @conversation.user_id      # who is the sender of the message? this user!
    @message.conversation_id = @conversation.id     # which conversation? this user + someone else. 
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
    @message.read = true
  end

  # POST /messages
  def create
    if the_other_user == 'DELETED'
      redirect_to conversation_messages_path(@conversation.id), notice: 'That user is deleted!'
    else
      @message = Message.new(params[:message])
      @message.source_id = @conversation.user_id
      @message.conversation_id = @conversation.id
      respond_to do |format|
        if @message.save
          format.html { redirect_to conversation_messages_path(@message.conversation_id), notice: 'Your message was sent!' }
        else
          format.html { render action: "new" }
        end
      end
    end
  end

  # PUT /messages/1
  def update
    @message = Message.find(params[:id])
    if @message.read == true
      redirect_to conversation_messages_path(@message.conversation_id)
    else
      @message.read = true
      respond_to do |format|
        if @message.update_attributes(params[:message])
          format.html { redirect_to conversation_messages_path(@message.conversation_id) }
        else
          format.html { render action: "edit" }
        end
      end
    end
  end

  # DELETE /messages/1
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to conversation_messages_path(@message.conversation_id) }
    end
  end
  

  private

  def the_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
    
  def the_user
    @user = User.find(@conversation.user_id)
  end 
  
  def the_other_user
    @other_user = User.find_by_id(@conversation.other_id) 
    if @other_user
      @other_user.screen_name
    else
      'DELETED'
    end
  end 
  
  def create_other_message
    if the_other_user != 'DELETED'
      @other_message = Message.new
      @other_message.user_id = @conversation.other_id
      @other_message.source_id = @message.source_id
      @other_conversation = Conversation.find_or_create_by_user_id_and_other_id(@conversation.other_id,@conversation.user_id)
      @other_message.conversation_id = @other_conversation.id
      @other_message.msg_text = @message.msg_text
      logger.info @other_message.inspect
      @other_message.save
      flash[:notice] = 'Yay, an "Other" Message was created.'
    end
  end

  
end
