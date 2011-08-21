Feature: I love cukes

  @tag1 @tag2
  Scenario: Something
    Given this
    When I do that
    Then all is well

  @tag3 @tag4
  Scenario Outline: My scenario outline
    Given I have "<cukes>" cukes

  Examples:
    | cukes |
    | 10    |
    | 11    |

  @tag5 @tag6
  Scenario Outline: My scenario outline
    Given I have "<cukes>" cukes

    @tag7 @tag8
  Examples:
    | cukes |
    | 10    |