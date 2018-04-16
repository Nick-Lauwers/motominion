class InvitationsController < ApplicationController
  
  before_action :logged_in_user
  before_action :club_admin
  before_action :get_club
  
  def new
    @invitation = current_user.sent_invitations.build
  end
  
  def create
    
    emails = params[:invitation][:email].split(/[\s,;]/)
      
    emails.each do |email|
      
      @invitation = current_user.sent_invitations.build(email:   email, 
                                                        club_id: @club.id)
      
      if @invitation.save  
        InvitationMailer.invitation_received(@invitation).deliver_now
        flash[:success] = "Update complete!"
        
      else
        flash[:failure] = "Invitations failed to send. Please try again."
      end
    end
    
    redirect_to posts_club_path(@club)
  end
  
  private
  
    def invitation_params
      params.require(:invitation).permit(:email, :club_id, :recipient_id)
    end
    
    # Before filters
    
    # Identifies club id.
    def get_club
      @club = Club.find(params[:club_id])
    end
end