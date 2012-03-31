module CukeIterations
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
          scenario_name: scenario.name,
          line: scenario.line,
          tags: @feature_tags + scenario.tags.map { |t| t.name }
      }
    end

    def scenario_outline(outline)
      @outline_tags = outline.tags.map { |t| t.name }
      @outline_name = outline.name
    end

    def examples(examples)
      examples.rows.each do |row|
        next if row == examples.rows.first

        @discovered_scenarios << {
            scenario_name: @outline_name,
            line: row.line,
            tags: @feature_tags + @outline_tags + examples.tags.map { |t| t.name },
            example_row: Hash[*examples.rows.first.cells.zip(row.cells).flatten]
        }
      end
    end

    def method_missing(sym, *args, &block)
      # We don't care
    end
  end
end
