class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account Activation"
  end

  def log_in(user)
    @user = user
    mail to: user.email, subject: "The Magic Link"
  end
  
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password Reset"
  end
end
