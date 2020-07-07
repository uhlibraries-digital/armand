module LanguageService
  mattr_accessor :authority
  self.authority = Qa::Authorities::Local.subauthority_for('language_terms')

  def self.select_all_options
    authority.all.map do |element|
      [element[:label], element[:id]]
    end
  end

  def self.label(id)
    Rails.logger.info("ID: #{id}, AUTHORITY: #{authority.find(id).inspect}")
    authority.find(id).fetch('term')
  end

end
