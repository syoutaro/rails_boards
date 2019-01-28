require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.production?
    CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: ENV['ACCESS_KEY_ID'],
        aws_secret_access_key: ENV['SECRET_ACCESS_KEY'],
        region: ENV['AWS_REGION']
        }

        config.fog_directory  = ENV['AWS_BUCKET_NAME']
        config.asset_host = ENV['AWS_BUCKET_URL']
    end
end