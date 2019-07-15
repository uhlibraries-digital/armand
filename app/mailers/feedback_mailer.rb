class FeedbackMailer < ActionMailer::Base
  layout 'mailer'

  def feedback_email(attr)    
    @from = attr[:from]
    @from = Settings.email.default_from if @from.blank?
    
    @from_address = attr[:from]
    @from_address = "Unknown" if @from_address.blank?
    @type = attr[:type]
    @user_agent = attr[:user_agent]
    @url = attr[:url]
    @comment = attr[:comment]

    mail(
      to: Settings.email.to,
      from: @from,
      subject: "#{I18n.t('hyrax.product_name')} :: #{I18n.t('feedback.subject')} :: #{@type}"
    )
  end

end