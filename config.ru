# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

if Rails.env.production?
  DelayedJobWeb.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(ENV['AUTH_USERNAME'], username) &&
      ActiveSupport::SecurityUtils.secure_compare(ENV['AUTH_PASSWORD'], password)
  end
end

run Rails.application
Rails.application.load_server
