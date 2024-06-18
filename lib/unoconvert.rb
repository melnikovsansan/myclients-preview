module Unoconvert
  module_function

  def call(input_path, output_path, **filter_options)
    Bash[
      'unoconvert',
      input_path,
      output_path,
      *filter_options.map { |key, value| "--filter-option #{key.to_s.camelize}=#{value}" }
    ]
  end
end
