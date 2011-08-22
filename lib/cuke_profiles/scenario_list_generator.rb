module CukeProfiles
  class ScenarioListGenerator
    class << self
      def for_profile(parsed_features, profile)
        parsed_features.select { |f| (f[:tags] & profile[:include_tags]).any? }
      end
    end
  end
end