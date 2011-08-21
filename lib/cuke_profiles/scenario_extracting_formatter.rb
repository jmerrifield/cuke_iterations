module CukeProfiles
  class ScenarioExtractingFormatter
    attr_reader :discovered_scenarios

    def initialize
      @discovered_scenarios = []
      @feature_tags = []
    end

    def feature(feature)
      @feature_tags = feature.tags.map { |t| t.name }
    end

    def scenario(scenario)
      @discovered_scenarios << {
          line: scenario.line,
          tags: @feature_tags + scenario.tags.map { |t| t.name }
      }
    end

    def examples(examples)
      examples.rows.each do |row|
        next if row == examples.rows.first

        @discovered_scenarios << {line: row.line}
      end
    end

    def method_missing(sym, *args, &block)
      # We don't care
    end
  end
end
