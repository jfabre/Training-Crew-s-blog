Feature: Home page
  In order to view all the awesome stuff on the home page
  As a reader
  I want posts, categories and videos
  
  Scenario: View Category on Home
    Given the following categories exist
    |slug|title|
    |cat1|category1|
    |cat2|category2|
    When I am on the home page
    Then I should see "category1"
    And I should see "category2"

  Scenario: View Last Five Posts sorted by descending data
    Given the following posts exist
    |slug|title|published_at|excerpt|body|
    |post1|Post 1|12/25/09| test post 1|Lorem Ipsum 1|
    |post2|Post 2|01/01/10| test post 2|Lorem Ipsum 2|
    |post3|Post 3|01/02/10| test post 3|Lorem Ipsum 3|
    |post4|Post 4|01/03/10| test post 4|Lorem Ipsum 4|
    |post5|Post 5|01/04/10| test post 5|Lorem Ipsum 5|
    |post6|Post 6|01/05/10| test post 6|Lorem Ipsum 6|
    When I am on the home page
    Then I should not see "Post 1"
    And I should see "Post 2"
    And I should see "Post 3"
    And I should see "Post 4"
    And I should see "Post 5"
    And I should see "Post 6" 
    
  Scenario: View latest video on Home
    Given the following videos exists
    |name   | description | created_at|
    |video1 | desc1       | 12/12/2000|
    |video2 | desc2       | 12/12/2005|
    When I am on the home page
    Then I should see "desc2"
    And I should not see "desc1"
