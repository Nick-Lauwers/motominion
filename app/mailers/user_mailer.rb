class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account Activation"
  end

  def log_in(user)
    @user = user
    mail to: user.email, subject: "#{Emoji.find_by_alias("sparkles").raw} The Magic Link #{Emoji.find_by_alias("sparkles").raw}"
  end
  
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "#{Emoji.find_by_alias("closed_lock_with_key").raw} Password Reset"
  end
end

# Nick, we received a request to reset your password. If this request was sent
# by you, click on the link below to proceed...