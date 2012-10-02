class Conversation < ActiveRecord::Base
  attr_accessible :other_id, :user_id
  
  belongs_to :user # , :counter_cache => true
  has_many :messages, :dependent => :destroy
    
    
  # not exactly optimal for scaling...how would you manage this differently? why?                   
  def other_screen_name
    other = User.find_by_id(self.other_id) 
    other.try(:screen_name) || '[deleted]'
  end

  
end
