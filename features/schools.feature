Feature:

  Scenario: Create a new school
    Given I am logged in as a user
    When I go to the new school page
    And I fill in "Magna Vista" for the name
    And I click the create school button
    Then I should "Magna Vista" in the school list

