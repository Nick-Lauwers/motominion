class ApplicationMailer < ActionMailer::Base
  default from: "automated@motominion.com"
  layout 'mailer'
end