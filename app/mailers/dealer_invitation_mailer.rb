class DealerInvitationMailer < ApplicationMailer
  def dealer_invitation_received(dealer_invitation)
    @dealer_invitation = dealer_invitation
    mail to: dealer_invitation.email, subject: "You Received an Invitation!"
  end
end
