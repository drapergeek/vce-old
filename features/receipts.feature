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

 Scenario: Creating a receipt creates campers with same information
    Given I am logged in as a user
    When I go to the receipts new page
    And I fill in the required fields
    And I fill in the following information for campers:
      | name          | number  | collage_count  | num  | amount |
      | John Doe      | CB332   | 2              | 1    | 200.00 |
      | Sarah Turner  | CG111   | 0              | 2    | 205.00 |
      | Sarah Smith   | CG121   | 1              | 3    | 10.00  |
    And I submit the form
    Then I see that the receipt was created
    And the following campers should exist:
      | name         | number | collage_count | amount |
      | John Doe     | CB332  | 2             | 200.00 |
      | Sarah Turner | CG111  | 0             | 205.00 |
      | Sarah Smith  | CG121  | 1             | 10.00  |
    When I go to the receipts new page
    And I fill in the required fields
    And I fill in the following information for campers:
      | name          | number  | collage_count  | num  | amount |
      | John Doe      | CB332   | 2              | 1    | 200.00 |
      | Sarah Turner  | CG111   | 0              | 2    | 205.00 |
      | Sarah Smith   | CG121   | 1              | 3    | 10.00  |
    And I submit the form
    Then I see that the receipt was created
    And the following campers should exist:
      | name         | number | collage_count | amount |
      | John Doe     | CB332  | 4             | 400.00 |
      | Sarah Turner | CG111  | 0             | 410.00 |
      | Sarah Smith  | CG121  | 2             | 20.00  |

