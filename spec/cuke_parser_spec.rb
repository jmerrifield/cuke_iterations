require 'spec_helper'
include CukeProfiles

describe "Extracting scenarios" do
  before do
    features_dir = File.join(File.dirname(__FILE__), '..', 'example', 'features')

    @parsed_features = CukeParser.parse_features(features_dir)
  end

  it "should find all the scenarios and examples" do
    expected_features = [
      {filename: 'cuking_rocks.feature', line: 10},
      {filename: 'cuking_rocks.feature', line: 21},
      {filename: 'cuking_rocks.feature', line: 22},
      {filename: 'i_love_cukes.feature', line: 4},
      {filename: 'i_love_cukes.feature', line: 15},
      {filename: 'i_love_cukes.feature', line: 16},
      {filename: 'i_love_cukes.feature', line: 25},
    ]

    parsed_files_with_lines = @parsed_features.map{|x| {filename: x[:filename], line: x[:line]}}
    parsed_files_with_lines.should =~ expected_features
  end

  it "should read scenario-level tags" do
    @parsed_features.should include filename: 'i_love_cukes.feature',
      line: 4,
      tags: ['@tag1', '@tag2']
  end

  it "should read feature-level tags on scenarios" do
    @parsed_features.should include filename: 'cuking_rocks.feature',
      line: 10,
      tags: ['@feature_tag1', '@feature_tag2']
  end

  it "should read scenario-level tags on example rows" do
    @parsed_features.should include filename: 'i_love_cukes.feature',
      line: 15,
      tags: ['@tag3', '@tag4']
  end

  it "should read feature-level tags on example rows" do
    @parsed_features.should include filename: 'cuking_rocks.feature',
      line: 21,
      tags: ['@feature_tag1', '@feature_tag2']
  end

  it "should read example-group tags on example rows" do
    @parsed_features.should include filename: 'i_love_cukes.feature',
      line: 25,
      tags: ['@tag5', '@tag6', '@tag7', '@tag8']
  end
end