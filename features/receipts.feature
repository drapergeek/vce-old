Feature: Receipt Management
  As a user
  I want to be able to input, edit and delete receipts
  so that I can track payments for camper

  Scenario:
    Given I am logged in as a user
    When I go to the receipts new page
    Then I should see the receipts form

 @javascript
 Scenario:
    Given I am logged in as a user
    When I go to the receipts new page
    And I fill in the required fields
    And I submit the form
    Then I see that the receipt was created
    And the receipted person should have been sent an e-mail
