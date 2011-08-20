Feature: My test feature
  In order to be awesome
  As a cuker
  My cukes should get blasted across hundreds of test machines

  Background:
    Given I have "10" cukes

  Scenario: My scenario
    When I check my cukes
    Then I should have "10" cukes

  Scenario Outline: My scenario outline
    When I check my cukes
    Then I should have '<cukes>' cukes
    And I they should be '<colour>' in colour

  Examples:
    | cukes | colour |
    | 10    | green  |
    | 11    | red    |