Feature: Use Navigation
  In order to move to all PingPong screens
  As a Zestian
  Should be able to have access to all the pages

  Scenario: Go to Match Screen
    Given I am on Zest Ladders
    When I follow "History"
    Then I should be on Zest Ping Pong History

  Scenario: Go to Players Screen
    Given I am on Zest Ladders
    When I follow "Players"
    Then I should be on Players

  Scenario: Go to Ladder Screen
    Given I am on Players
    When I follow "Ladder"
    Then I should be on Zest Ladders
