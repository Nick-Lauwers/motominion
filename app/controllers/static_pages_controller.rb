# completed

class StaticPagesController < ApplicationController
  
  def home
    @feed_items = Vehicle.all
  end

  def help
  end
  
  def about
  end
  
  def how_it_works
  end
  
  def dashboard
    
    @conversations = Conversation.where(next_contributor_id: current_user.id,
                                        latest_message_read: false)
                                        
    @questions     = Question.where(vehicle: current_user.vehicles, 
                                    read_at: nil)
                                    
    @test_drives   = Appointment.where(seller_id: current_user.id)
  end
  
  def legal
  end
end