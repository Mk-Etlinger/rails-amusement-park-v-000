class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    if !enough_tickets? && !tall_enough?
      "Sorry. You do not have enough tickets to ride the #{self.attraction.name}. You are not tall enough to ride the #{self.attraction.name}."
    elsif !enough_tickets?
      "Sorry. You do not have enough tickets to ride the #{self.attraction.name}."
    elsif !tall_enough?
      "Sorry. You are not tall enough to ride the #{self.attraction.name}."
    else
      self.user.update(tickets: take_tickets, nausea: add_nausea, happiness: add_happiness)
    end      
  end
  
  def enough_tickets?
    (self.user.tickets - self.attraction.tickets) > 0
  end

  def take_tickets
    (self.attraction.tickets - self.user.tickets).abs
  end
  
  def tall_enough?
    (self.user.height - self.attraction.min_height) > 0
  end  

  def add_nausea
    self.user.nausea + self.attraction.nausea_rating
  end

  def add_happiness
    self.user.happiness + self.attraction.happiness_rating
  end  
  
end
