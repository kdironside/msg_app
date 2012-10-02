class ConversationsController < ApplicationController
  before_filter :the_user
  before_filter :the_other_user, :only => [:create]
  before_filter :find_or_create_conversation, :only => [:create]
  
  # GET /conversations
  def index
    @conversations = the_user.conversations.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /conversations/1
  def show
    @conversation = Conversation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /conversations/new
  def new
    @conversation = Conversation.new
    @conversation.user_id = the_user.id
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /conversations
  def create
    
    respond_to do |format|
      if @conversation.save
        format.html { redirect_to new_conversation_message_path(@conversation.id)}
      else
        format.html { render action: "new" }
      end
    end
  end

  # DELETE /conversations/1
  def destroy
    @conversation = Conversation.find(params[:id])
    @conversation.destroy

    respond_to do |format|
      format.html { redirect_to user_conversations_path(@user) }
    end
  end
 

  private
  
  def the_user
    @user = User.find_by_id(params[:user_id])
  end
  
  def the_other_user
    @other_user = User.find_by_id(params[:conversation][:other_id])
  end
    
  def find_or_create_conversation
    @conversation = Conversation.find_or_create_by_user_id_and_other_id(@user.id,@other_user.id)
    flash[:notice] = 'Yay'
  end
  
end  
     