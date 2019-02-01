AssetSync.configure do |config|
  config.fog_provider = 'AWS'
  config.fog_directory = ENV['AWS_BUCKET_NAME']
  config.aws_access_key_id = ENV['ACCESS_KEY_ID'],
  config.aws_secret_access_key = ENV['SECRET_ACCESS_KEY']
  config.manifest = true
  config.fog_region = ENV['AWS_REGION']
end