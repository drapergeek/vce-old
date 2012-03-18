Feature: Receipt Management
  As a user
  I want to be able to input, edit and delete receipts
  so that I can track payments for camper

  Scenario:
    Given I am logged in as a user
    When I go to the receipts new page
    Then I should see the receipts form
