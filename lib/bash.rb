module Bash
  module_function

  def [](*script, squish: true)
    script = script.join(" ")
    script = script.squish if squish
    puts
    puts script
    start_time = Time.now
    result = `#{script}`
    spend_time = Time.now - start_time
    puts "Complete in #{spend_time.round(3)}s"
    result
  end
end
