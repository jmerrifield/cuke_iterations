Feature: I love cukes

  @tag1 @tag2
  Scenario: Scenario with tags
    Given I have "10" cukes
    When I check my cukes
    Then I should have "10" cukes

  @tag3 @tag4
  Scenario Outline: Scenario outline with tags
    Given I have "<cukes>" cukes

  Examples:
    | cukes |
    | 10    |
    | 11    |

  @tag5 @tag6
  Scenario Outline: Scenario outline with tags and tagged example sections
    Given I have "<cukes>" cukes

    @tag7 @tag8
  Examples:
    | cukes |
    | 10    |