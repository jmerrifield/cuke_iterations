module CukeIterations
  class ScenarioListGenerator
    class << self
      def for_iteration(scenarios, iteration_info)
        scenarios.select do |s|
          next if is_excluded?(s, iteration_info)
          is_included_by_tag?(s, iteration_info) || no_include_tags_specified?(iteration_info)
        end
      end

      def no_include_tags_specified?(iteration)
        iteration[:include_tags] == []
      end

      def is_included_by_tag?(scenario, iteration)
        (scenario[:tags] & iteration[:include_tags]).any?
      end

      def is_excluded?(scenario, iteration)
        (scenario[:tags] & iteration[:exclude_tags]).any?
      end
    end
  end
end