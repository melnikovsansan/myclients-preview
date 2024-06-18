CarrierWave.configure do |config|
  unless Rails.env.test?
    config.fog_provider = 'fog/aws' # required
    config.fog_credentials = {
        provider: 'AWS', # required
        aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'], # required unless using use_iam_profile
        aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], # required unless using use_iam_profile
        #     use_iam_profile:       true,                         # optional, defaults to false
        region: ENV['AWS_REGION'] || 'us-east-2', # optional, defaults to 'us-east-1'
        #     host:                  's3.example.com',             # optional, defaults to nil
        #     endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
    }
    config.storage = :fog
    config.fog_directory = ENV['AWS_BUCKET_NAME'] # required
    config.fog_public = false # optional, defaults to true
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
    config.fog_authenticated_url_expiration = 43200 # 12 hrs
  else
    config.storage = :file
    config.cache_dir = Rails.root.join('tmp','carrierwave')
  end
end
