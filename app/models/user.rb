class User < ActiveRecord::Base
  
  attr_accessible :email, :name, :screen_name
  
  has_many :conversations, :dependent => :destroy      
            
  has_many :messages, :through => :conversations,
            :order => 'created_at DESC'
  
  validates_presence_of :email, :name, :screen_name
  
end
