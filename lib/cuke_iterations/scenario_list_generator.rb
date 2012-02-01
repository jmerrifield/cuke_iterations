module CukeIterations
  class ScenarioListGenerator
    class << self
      def for_iteration(parsed_features, iteration)
        parsed_features.select do |f|
          next if (f[:tags] & iteration[:exclude_tags]).any?
          (f[:tags] & iteration[:include_tags]).any? || iteration[:include_tags] == []
        end
      end
    end
  end
end