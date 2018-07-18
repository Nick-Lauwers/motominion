# completed

class StaticPagesController < ApplicationController
  
  def home
    
    if current_user && current_user.personalized_search.present?
      @personalized_search = current_user.personalized_search
    else
      @personalized_search = PersonalizedSearch.new
    end
    
    # @personalized_search = current_user.build_personalized_search
    
    @feed_items = Vehicle.
                  where(sold_at: nil).
                  # where.not(posted_at: nil).
                  paginate(page: params[:page], per_page: 9, total_entries: 18).
                  order(bumped_at: :desc)
    
    # @filterrific = initialize_filterrific(
      
    #   Vehicle,
    #   params[:filterrific],
      
    #   select_options: {
    #     sorted_by:             Vehicle.options_for_sorted_by,
    #     with_vehicle_make_id:  VehicleMake.options_for_select,
    #     with_vehicle_model_id: VehicleModel.options_for_select
    #   },
      
    #   persistence_id: false,
    #   default_filter_params: {},
      
    #   available_filters: [
    #     :with_vehicle_make_id, 
    #     :with_vehicle_model_id,
    #     :with_city
    #   ],
    # ) or return
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
    
    if current_user.dealership_id.present?
      @questions = Question.where(
                     vehicle: 
                       Dealership.find(current_user.dealership_id).vehicles,
                     read_at: nil
                   )
                   
    else
      @questions = Question.where(vehicle: current_user.vehicles, 
                                      read_at: nil)
    end

    @customers = Appointment.where("seller_id = ? AND date >= ?",
                                       current_user.id,
                                       Time.now)
  end
  
  def tour
  end
  
  def legal
  end
end