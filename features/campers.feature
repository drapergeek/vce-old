Feature:
  As a user
  I want to be able to enter camper details
  So that I can track their information

  Scenario: Create a new camper
    Given I am logged in as a user
    When I go to the campers new page
    And I fill in the necessary fields
    And I click the create camper button
    Then I should see the new camper created

  Scenario: Handle Date Select Properly
    Given I am logged in as a user
    When I go to the campers new page
    And I fill in the necessary fields
    When I fill in the birthdate as '4/12/2005'
    And I click the create camper button
    Then I should see the birthday as "April 12, 2005"
    When I click the edit button
    Then I should see the date should be selected as '4/12/2005'

  Scenario:
    Given I am logged in as a user
    Given a room exists with a name of "RJ432" and a pack name of "Skunks"
    When I go to the campers new page
    And I fill in the necessary fields
    And I select "RJ432" for the room
    And I click the create camper button
    Then I should see the new camper created
    And its "Pack" should be "Skunks"
    And its "Room" should be "RJ432"
