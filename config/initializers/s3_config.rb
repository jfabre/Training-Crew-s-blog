# config/initializers/load_config.rb
S3_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/s3.yml")

