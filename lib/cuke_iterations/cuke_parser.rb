require 'gherkin'

module CukeIterations
  class CukeParser
    class << self
      def parse_features(dir)
        scenarios = []
        Dir.glob(File.join(dir, '**/*.feature')).each do |feature_file|
          formatter = ScenarioExtractingFormatter.new
          parser = Gherkin::Parser::Parser.new (formatter)
          text = File.open(feature_file, 'r') { |f| f.read }
          parser.parse(text, __FILE__, __LINE__-1)

          scenarios << formatter.discovered_scenarios.each {|s| s[:filename] = File.basename(feature_file)}
        end

        scenarios.flatten
      end
    end
  end
end