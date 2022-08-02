Sidekiq.configure_server do |s|
  if ENV["RAILS_LOG_LEVEL"].present?
    s.logger.level = ENV["RAILS_LOG_LEVEL"].to_sym
  end

  ActiveJob::Base.logger = s.logger
end

begin
  Sidekiq::Cron::Job.create(name: 'Clean out searches older than 20 minutes', cron: '*/20 * * * *', class: 'DeleteOldSearchesJob')
  # Sidekiq::Cron::Job.create(name: 'Clean out derivatives tmp directory older than 1 day', cron: '0 0 * * *', class: 'DeleteMiniMagickFilesJob')
rescue Redis::CannotConnectError => e
  Rails.logger.warn "Cannot create sidekiq-cron jobs: #{e.message}"
end