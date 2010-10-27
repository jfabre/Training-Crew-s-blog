Feature: Post and comments display
  In order to interact with the author
  As a reader
  I want to be able to see posts and write comments
  
  Scenario: Comments should exist
    Given a post exists with title: "something very groovy", slug: "something_very_groovy", body: "Lorem Ipsum 1", published_at: "12/01/2009"
    When I am on the "2009/01/12/something_very_groovy" post page
    Then I should see "something very groovy"
    And I should see "Lorem Ipsum 1"
  
  Scenario: Comment page form
    Given the following posts exist
      |slug   |title  |published_at |  body        |
      |post1  |Post 1 |12/25/2009   | Lorem Ipsum 1|
    When I am on the "2009/12/25/post1" post page
      And I fill in "name" with "Joe Blow"
      And I fill in "comment" with "Super commentaire"
      And I press "Add"
    Then I should see "Joe Blow"
      And I should see "Super commentaire" 
      And a comment should exist with user: "Joe Blow", text: "Super commentaire" 
      
   Scenario: View Comments
    Given a post exists with title: "something very groovy", body: "Lorem Ipsum 1", published_at: "12/01/2009", slug: "something_very_groovy"
    And the following comments exist for a post with title "something very groovy"
     | user  | website  |   text                  |
     | author1 | url    |  Lorem Ipsum Comment 1  |
     | author2 | url    |  Lorem Ipsum Comment 2  |
     | author3 | url    |  Lorem Ipsum Comment 3  |
     | author4 | url    |  Lorem Ipsum Comment 4  |
    Then the post with title "something very groovy" should have 4 comments
    When I am on the home page
    And I follow "4 commentaires"
    Then I should see "author1"
    And I should see "author2"
    And I should see "author3"
    And I should see "author4"

  Scenario: The post should have a underscore style title
    Given a post exists with title: "something very groovy", body: "Lorem Ipsum 1", published_at: "12/01/2009", slug: "something_very_groovy"
    Then the post with title "something very groovy" should have url "/2009/12/01/something_very_groovy"

  Scenario: Link off of home
    Given a post exists with title: "something very groovy", body: "Lorem Ipsum 1", published_at: "12/01/2009", slug: "super-slug"
    And I am on the home page
    When I follow "0 commentaire"
    Then I should see "something very groovy"
    And I should see "Lorem Ipsum 1"
  
  Scenario: Bad link
    Given I go to "/2009/01/01/bad-url"
    Then I should see "404"
  
  Scenario: Category link
    Given a post exists with title: "something very groovy", body: "Lorem Ipsum 1", published_at: "12/01/2009", slug: "something_very_groovy"
    Given I go to "/some-category/something_very_groovy"
    Then I should see "something very groovy"
    And I should see "Lorem Ipsum 1"
  
 
    