ActionMailer::Base.delivery_method = Settings.email.delivery_method

ActionMailer::Base.smtp_settings = {
  address:              Settings.email.smtp.address,
  port:                 Settings.email.smtp.port,
  enable_starttls_auto: Settings.email.smtp.enable_starttls_auto
}