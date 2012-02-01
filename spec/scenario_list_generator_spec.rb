require 'spec_helper'

describe "Scenario list generator" do
  before do
    @parsed_features = [
        @test1 = {filename: 'cuking_rocks.feature', line: 10, tags: ['@tag3', '@tag4']},
        @test2 = {filename: 'cuking_rocks.feature', line: 14, tags: ['@tag2', '@tag9']},
        @test3 = {filename: 'cuking_rocks.feature', line: 18, tags: ['@tag3', '@tag8']},
    ]
  end

  it "should include all non-excluded scenarios if no include tags are specified" do
    iteration = {
        name: "iphone",
        include_tags: [],
        exclude_tags: ['@tag8']
    }

    list = ScenarioListGenerator.for_iteration(@parsed_features, iteration)

    list.should =~ [@test1, @test2]
  end

  it "should include the scenarios that have tags specified in the iteration" do
    iteration = {
        name: "iphone",
        include_tags: ['@tag2', '@tag8'],
        exclude_tags: []
    }

    list = ScenarioListGenerator.for_iteration(@parsed_features, iteration)

    list.should =~ [@test2, @test3]
  end

  it "should exclude scenarios that the iteration specifies to exclude" do
    iteration = {
        name: "android",
        include_tags: ['@tag3'],
        exclude_tags: ['@tag8'],
    }

    list = ScenarioListGenerator.for_iteration(@parsed_features, iteration)

    list.should =~ [@test1]
  end
end