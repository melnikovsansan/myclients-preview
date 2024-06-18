Aws.config.update(
  {
    region: ENV['AWS_REGION'] || 'us-west-2',
    credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
  }
)
