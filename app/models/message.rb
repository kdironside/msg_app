class Message < ActiveRecord::Base
  attr_accessible :msg_text, :read, :user_id
  
  belongs_to :conversation
  
end
