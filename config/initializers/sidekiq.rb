redis_url = ENV.include?('REDIS_URL') ? ENV['REDIS_URL'] : 'redis://redis:6379/1' 
puts redis_url

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url }
  schedule_file = 'config/schedule.yml'

  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file) if File.exist?(schedule_file) && Sidekiq.server?
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url }
end
