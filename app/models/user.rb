class User < ActiveRecord::Base
  has_many :rides
  has_many :attractions, through: :rides
  
  has_secure_password

  def mood
    if happy?
      "happy"
    else
      "sad"  
    end
    
  end
  
  def happy?
    self.happiness > self.nausea
  end
  
end
