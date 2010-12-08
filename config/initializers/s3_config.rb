# config/initializers/load_config.rb

if File.exists?("#{RAILS_ROOT}/config/s3.yml")
  S3_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/s3.yml")
else
  S3_CONFIG = {}
  S3_CONFIG['access_key_id'] = ENV['S3_KEY']
  S3_CONFIG['secret_access_key'] = ENV['S3_SECRET']
end
