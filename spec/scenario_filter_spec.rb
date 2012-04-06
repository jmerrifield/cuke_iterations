require 'spec_helper'

describe ScenarioFilter do
  before do
    @scenarios = [
        @test1 = {filename: 'cuking_rocks.feature', line: 10, tags: %w(@tag3 @tag4)},
        @test2 = {filename: 'cuking_rocks.feature', line: 14, tags: %w(@tag2 @tag9)},
        @test3 = {filename: 'cuking_rocks.feature', line: 18, tags: %w(@tag3 @tag8)},
    ]
  end

  subject { ScenarioFilter }

  it "should include all non-excluded scenarios if no include tags are specified" do
    list = subject.filter_scenarios(@scenarios, include: [], exclude: %w(@tag8))
    list.should =~ [@test1, @test2]
  end

  it "should include the scenarios that have tags specified in the iteration" do
    list = subject.filter_scenarios(@scenarios, include: %w(@tag2 @tag8), exclude: [])
    list.should =~ [@test2, @test3]
  end

  it "should exclude scenarios that the iteration specifies to exclude" do
    list = subject.filter_scenarios(@scenarios, include: %w(@tag3), exclude: %w(@tag8))
    list.should =~ [@test1]
  end
end