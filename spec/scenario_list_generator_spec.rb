require 'spec_helper'

describe "Scenario list generator" do
  before do
    @parsed_features = [
        @test1 = {filename: 'cuking_rocks.feature', line: 10, tags: ['@tag3', '@tag4']},
        @test2 = {filename: 'cuking_rocks.feature', line: 14, tags: ['@tag2', '@tag9']},
        @test3 = {filename: 'cuking_rocks.feature', line: 18, tags: ['@tag8']},
    ]
  end

  it "should include the scenarios that have tags specified in the profile" do
    profile = {
        name: "iphone",
        include_tags: ['@tag2', '@tag8']
    }

    list = ScenarioListGenerator.for_profile(@parsed_features, profile)

    list.should =~ [@test2, @test3]
  end
end