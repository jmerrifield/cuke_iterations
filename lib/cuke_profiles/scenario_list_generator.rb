module CukeProfiles
  class ScenarioListGenerator
    class << self
      def for_profile(parsed_features, profile)
        parsed_features.select do |f|
          next if (f[:tags] & profile[:exclude_tags]).any?
          (f[:tags] & profile[:include_tags]).any?
        end
      end
    end
  end
end