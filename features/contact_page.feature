Feature: Top level pages
  In order to contact the blog author
  As a reader
  I want to be able to send him a message
  
  Scenario: Contact page should exist
    Given I am on the contact page
    Then I should see "Contact"
  
  Scenario: Contact page form
    Given I am on the contact page
    When I fill in "name" with "joe blow"
    And I fill in "message" with "Hello"
    And I press "Continue"
    Then a message should be sent
  
  Scenario: Resume page should exist
    Given I am on the resume page
    Then I should see "Resume"
    
