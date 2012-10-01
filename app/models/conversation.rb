class Conversation < ActiveRecord::Base
  attr_accessible :other_id, :user_id
  
  belongs_to :user # , :counter_cache => true
  has_many :messages, :dependent => :destroy
                       
  def other_screen_name
    other = User.find_by_id(self.other_id) 
    if other
      other.screen_name
    else
      '[deleted]'
    end
  end
  
  def user_screen_name
    user = User.find(self.user_id)
    user.screen_name
  end

  
end
