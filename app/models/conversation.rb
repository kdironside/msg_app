class Conversation < ActiveRecord::Base
  attr_accessible :other_id, :user_id
  
  belongs_to :user 
  has_many :messages, :dependent => :destroy   
                      
  def other_screen_name
    other = User.find_by_id(self.other_id) 
    other.try(:screen_name) || '[deleted]'
  end
  
end
