require 'gherkin'
require 'pathname'

module CukeIterations
  class CukeParser
    class << self
      def parse_features(dir)
        scenarios = []
        Dir.glob(File.join(dir, '**/*.feature')).each do |feature_file|
          text = File.open(feature_file, 'r') { |f| f.read }
          scenarios << parse_feature_file_content(text).each { |s| s[:filename] = relative_path(feature_file, dir) }
        end

        scenarios.flatten
      end

      def parse_feature_file_content(text)
        formatter = ScenarioExtractingFormatter.new
        parser = Gherkin::Parser::Parser.new (formatter)
        parser.parse(text, __FILE__, __LINE__-1)
        formatter.discovered_scenarios
      end

      private
      def relative_path(file, base_dir)
        Pathname.new(file).relative_path_from(Pathname.new(base_dir)).to_s
      end
    end
  end
end