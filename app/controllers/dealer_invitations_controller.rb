class DealerInvitationsController < ApplicationController
  
  before_action :logged_in_user
  before_action :get_dealership
  
  def new
    @dealer_invitation = current_user.sent_dealer_invitations.build
  end
  
  def create
    
    emails = params[:dealer_invitation][:email].split(/[\s,;]/)
      
    emails.each do |email|
      
      @dealer_invitation = current_user.
                             sent_dealer_invitations.
                             build(email:         email, 
                                   dealership_id: @dealership.id)
      
      if @dealer_invitation.save  
        DealerInvitationMailer.
          dealer_invitation_received(@dealer_invitation).
          deliver_now
        flash[:success] = "Invitations sent!"
        
      else
        flash[:failure] = "Invitations failed to send. Please try again."
      end
    end
    
    redirect_to @dealership
  end
  
  private
  
    def dealer_invitation_params
      params.require(:dealer_invitation).permit(:email, :dealership_id, 
                                                :recipient_id)
    end
    
    # Before filters
    
    # Identifies club id.
    def get_dealership
      @dealership = Dealership.find(params[:dealership_id])
    end
end