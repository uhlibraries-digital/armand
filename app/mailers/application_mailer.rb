class ApplicationMailer < ActionMailer::Base
  default from: Settings.email.default_from
  layout 'mailer'
end
