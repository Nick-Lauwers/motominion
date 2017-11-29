# completed

class StaticPagesController < ApplicationController
  
  def home
    @feed_items = Vehicle.
                  where(sold_at: nil).
                  where.not(posted_at: nil).
                  paginate(page: params[:page], per_page: 9, total_entries: 18).
                  order(bumped_at: :desc)
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
                                    
    @customers     = Appointment.where("seller_id = ? AND date >= ?",
                                       current_user.id,
                                       Time.now)
  end
  
  def tour
  end
  
  def legal
  end
end