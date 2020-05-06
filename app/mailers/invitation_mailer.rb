class InvitationMailer < ApplicationMailer
  
  def invitation_received(invitation)
    @invitation = invitation
    mail to: invitation.email, subject: "You Received an Invitation!"
  end
end