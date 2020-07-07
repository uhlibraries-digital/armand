module ApplicationHelper
  require 'edtf-humanize'

  def humanize_date(options)
    date = options[:value]
    begin
      humanized_date = date.collect {|d| Date.edtf(d).humanize}
    rescue NoMethodError => e
      Rails.logger.error(e)
      humanized_date = date
    end
    humanized_date.join('; ')
  end

  def language_term(value)
    LanguageService.label(value) { value }
  end

end
