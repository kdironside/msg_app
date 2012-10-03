class Message < ActiveRecord::Base
  before_validation :strip_msg_text_whitespace
  
  attr_accessible :msg_text, :read, :user_id
  
  belongs_to :conversation
  
  validates_presence_of :msg_text
  
private
  
  def strip_msg_text_whitespace
    self.msg_text.strip!
  end
  
  
end
