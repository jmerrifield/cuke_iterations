@feature_tag1 @feature_tag2
Feature: My test feature with tags
  In order to be awesome
  As a cuker
  I need to know how many cukes I have, and what colour they are

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