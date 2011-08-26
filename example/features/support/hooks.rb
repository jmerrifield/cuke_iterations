Before do |scenario|
  iteration = current_iteration(scenario)
  puts "This step is running in the '#{iteration}' iteration!"
end