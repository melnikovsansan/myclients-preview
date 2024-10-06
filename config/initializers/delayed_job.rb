if $ARGV.include?("jobs:work")
  Rails.application.config.after_initialize do
    Delayed::Backend::ActiveRecord::Job.logger.level = Logger::WARN
  end
end

Delayed::Worker.max_run_time = 10.minutes
Delayed::Worker.raise_signal_exceptions = :term
