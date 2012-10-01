class Message < ActiveRecord::Base
  attr_accessible :msg_text, :read, :user_id
  
  belongs_to :conversation # , :counter_cache => true
  belongs_to :user
  
end
