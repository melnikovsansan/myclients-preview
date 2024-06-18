module Bash
  module_function

  def [](*script, squish: true)
    script = script.join(" ")
    script = script.squish if squish
    puts script.soft_color(:yellow)
    start_time = Time.now
    result = `#{script}`
    spend_time = Time.now - start_time
    print 'Complete in '.soft_color(:green),
          spend_time.round(3),
          's'.soft_color(:green),
          "\n"
    result
  end
end
