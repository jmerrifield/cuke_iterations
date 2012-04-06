require 'spec_helper'
include CukeIterations

describe "Extracting scenarios" do
  before do
    features_dir = File.join(File.dirname(__FILE__), '..', 'example', 'features')

    @scenarios = CukeParser.parse_features(features_dir)
  end

  it "should find all the scenarios and examples" do
    expected_features = [
        {filename: 'cuking_rocks.feature', line: 10},
        {filename: 'cuking_rocks.feature', line: 21},
        {filename: 'cuking_rocks.feature', line: 22},
        {filename: 'subdirectory/i_love_cukes.feature', line: 4},
        {filename: 'subdirectory/i_love_cukes.feature', line: 15},
        {filename: 'subdirectory/i_love_cukes.feature', line: 16},
        {filename: 'subdirectory/i_love_cukes.feature', line: 25},
    ]

    parsed_files_with_lines = @scenarios.map { |x| {filename: x[:filename], line: x[:line]} }
    parsed_files_with_lines.should =~ expected_features
  end

  describe "reading tags" do
    before { @tag_info = @scenarios.map { |x| x.slice(:filename, :line, :tags) } }

    it "should read scenario-level tags" do
      @tag_info.should include filename: 'subdirectory/i_love_cukes.feature',
                               line: 4,
                               tags: ['@tag1', '@tag2']
    end

    it "should read feature-level tags on scenarios" do
      @tag_info.should include filename: 'cuking_rocks.feature',
                               line: 10,
                               tags: ['@feature_tag1', '@feature_tag2']
    end

    it "should read scenario-level tags on example rows" do
      @tag_info.should include filename: 'subdirectory/i_love_cukes.feature',
                               line: 15,
                               tags: ['@tag3', '@tag4']
    end

    it "should read feature-level tags on example rows" do
      @tag_info.should include filename: 'cuking_rocks.feature',
                               line: 21,
                               tags: ['@feature_tag1', '@feature_tag2']
    end

    it "should read example-group tags on example rows" do
      @tag_info.should include filename: 'subdirectory/i_love_cukes.feature',
                               line: 25,
                               tags: ['@tag5', '@tag6', '@tag7', '@tag8']
    end
  end

  describe "reading scenario information" do
    before { @scenario_info = @scenarios.map { |x| x.slice(:filename, :line, :scenario_name, :example_row) } }

    it "should read the names of scenarios" do
      @scenario_info.should include filename: 'subdirectory/i_love_cukes.feature',
                                    line: 4,
                                    scenario_name: 'Scenario with tags'
    end

    it "should read the outline name and row details of example rows" do
      @scenario_info.should include filename: 'cuking_rocks.feature',
                                    line: 22,
                                    scenario_name: 'My scenario outline',
                                    example_row: {'cukes' => '11', 'colour' => 'red'}
    end
  end
end