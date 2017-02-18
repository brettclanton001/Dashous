class ApplicationMailer < ActionMailer::Base
  default from: Settings.admin.email
  layout 'mailer'
end
