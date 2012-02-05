module CukeIterations
  class IterationFileFinder
    def find(features_dir, iteration_file = 'cuke_iterations.yml')
      raise 'features_dir cannot be nil' unless features_dir

      iteration_file_locations = [
          iteration_file,
          File.join(features_dir, iteration_file)
      ]

      location = iteration_file_locations.select { |location| File.exist? location }.first

      raise "Couldn't find iterations file, tried the following: #{iteration_file_locations.join(', ')}" unless location
      location
    end
  end
end