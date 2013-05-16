Feature: Add New Player
  In order to play
  As a Zestian
  Should be able to add a new player

Scenario: Add New Players
  Given I am on Players
  When I follow "New"
  Then I should be on New Player
  When I fill in the following:
    | First name              | Frodo       |
    | Last name               | Baggins     |
  When I press "Create Player"
  Then I should be on Players
  Then I should see "Frodo"
  Then I should see "Baggins"