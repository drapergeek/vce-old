Feature:

  Scenario: Add a new course
    Given I am logged in as a user
    When I go to the new course page
    And I fill in "Archery" for the name
    And I click the create course button
    Then I should "Archery" in the course list

