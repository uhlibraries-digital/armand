Sidekiq.configure_server do |s|
  if ENV["RAILS_LOG_LEVEL"].present?
    s.logger.level = ENV["RAILS_LOG_LEVEL"].to_sym
  end

  ActiveJob::Base.logger = s.logger
end