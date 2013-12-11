require 'yaml'

module CukeIterations
  class ScenarioFileWriter
    def write_scenarios(features_dir, iteration_file, out_file)
      iterations = ::YAML.load(File.read(iteration_file))

      all_scenarios = []
      features = CukeParser.parse_features(features_dir)
      iterations.each do |iteration_name, iteration|
        iteration_dir = File.join(features_dir, 'iterations', iteration_name, '..', '..')
        FileUtils.mkdir_p iteration_dir

        criteria = {
            include: iteration[:include_tags],
            exclude: iteration[:exclude_tags],
        }
        ScenarioFilter.filter_scenarios(features, criteria).each do |scenario|
          all_scenarios << File.join(iteration_dir, scenario[:filename] + ":#{scenario[:line]}")
        end
      end

      File.open(out_file, 'w') { |f| f.puts all_scenarios }
    end
  end
end
