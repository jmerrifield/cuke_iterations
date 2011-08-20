require 'spec_helper'
include CukeProfiles

describe "Extracting scenarios" do
  it "should find all the scenarios and examples" do
    features_dir = File.join(File.dirname(__FILE__), '..', 'examples')

    parsed_features = CukeParser.parse_features(features_dir)

    expected_features = [
      {filename: 'cuking_rocks.feature', line: 9},
      {filename: 'cuking_rocks.feature', line: 20},
      {filename: 'cuking_rocks.feature', line: 21},
      {filename: 'i_love_cukes.feature', line: 3}
    ]

    parsed_features.should =~ expected_features
  end
end