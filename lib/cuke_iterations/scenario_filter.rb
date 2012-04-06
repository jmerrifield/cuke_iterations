module CukeIterations
  class ScenarioFilter
    class << self
      def filter_scenarios(scenarios, criteria)
        scenarios.select do |s|
          next if is_excluded?(s, criteria)
          is_included_by_tag?(s, criteria) || no_include_tags_specified?(criteria)
        end
      end

      def no_include_tags_specified?(criteria)
        criteria[:include] == []
      end

      def is_included_by_tag?(scenario, criteria)
        (scenario[:tags] & criteria[:include]).any?
      end

      def is_excluded?(scenario, criteria)
        (scenario[:tags] & criteria[:exclude]).any?
      end
    end
  end
end