Feature: Add new match
  In order to schedule a match
  As a Zestian
  Should be able to create a match

Scenario: Add New Match
  Given a player named "Selina Kyle"
  Given a player named "Bruce Wanye"
  Given I am on Zest Ladders
  When I follow "Enter Match Result"
  Then I should be on New Match
  Then I select "Bruce Wanye" from "Winner"
  Then I select "Selina Kyle" from "Beats Loser"
  When I press "Create Match"
  Then I should be on Zest Ladders
  Then I should see "Bruce Wanye"
  Then I should see "Selina Kyle"
