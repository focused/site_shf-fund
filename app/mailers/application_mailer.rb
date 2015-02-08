class ApplicationMailer < ActionMailer::Base
  layout "mailer"

  default from: ENV["SMTP_USER_NAME"]
end
