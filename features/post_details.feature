Feature: Post and comments display
  In order to interact with the posts
  As a reader
  I want to be able to see posts or write comments
  
  Scenario: Comments should exist
    Given I am on the post detail page
    Then I should see "Comments"
  
  Scenario: Comment page form
    Given the following posts exist
    |slug|title|published_at|excerpt|body|
    |post1|Post 1|12/25/09| test post 1|Lorem Ipsum 1|
    When I am on the post detail page
    And I fill in "name" with "joe blow"
    And I fill in "comment" with "Super commentaire"
    And I press "Add"
    Then a comment with name:"Joe Blow", text: "Super commentaire" should exist  
   
   Scenario: View Comments
    Given a post exists with title: "something very groovy", body: "Lorem Ipsum 1", published_at: "12/01/2009"
    And the following comments exist for a post with title "something very groovy"
     | author  | created_at | url | email         | body                   |
     | author1 | 12/12/2009 | url | test@test.com | Lorem Ipsum Comment 1  |
     | author2 | 12/13/2009 | url | test1@test.com | Lorem Ipsum Comment 2 |
     | author3 | 12/14/2009 | url | test2@test.com | Lorem Ipsum Comment 3 |
     | author4 | 12/15/2009 | url | test3@test.com | Lorem Ipsum Comment 4 |
    Then the post with title "something very groovy" should have 4 comments
    When I am on the home page
    And I follow "something very groovy"
    Then I should see "author1"
    And I should see "author2"
    And I should see "author3"
    And I should see "author4"

  Scenario: The post should have a wordpress-style title
    Given a post exists with title: "something very groovy", body: "Lorem Ipsum 1", published_at: "12/01/2009"
    Then the post with title "something very groovy" should have url "/2009/12/01/something-very-groovy"

  Scenario: Link off of home
    Given a post exists with title: "something very groovy", body: "Lorem Ipsum 1", published_at: "12/01/2009"
    And I am on the home page
    When I follow "something very groovy"
    Then I should see "something very groovy"
    And I should see "Lorem Ipsum 1"
  
  Scenario: Bad link
    Given I go to "/2009/01/01/bad-url"
    Then I should see "404"
  
  Scenario: Category link
    Given a post exists with title: "something very groovy", body: "Lorem Ipsum 1", published_at: "12/01/2009"
    Given I go to "/some-category/something-very-groovy"
    Then I should see "something very groovy"
    And I should see "Lorem Ipsum 1"
  
 
    