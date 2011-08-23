Before do |scenario|
  profile = current_profile(scenario)
  puts "This step is running under the '#{profile}' profile!"
end