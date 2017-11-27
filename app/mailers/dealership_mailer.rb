class DealershipMailer < ApplicationMailer
  def dealership_activation(dealership)
    @dealership = dealership
    mail to: dealership.email, subject: "Account Activation"
  end
end