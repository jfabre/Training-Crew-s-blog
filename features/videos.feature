Feature: Videos listing
  In order to watch the videos
  As a reader
  I want to be able to see all the videos
  
  Scenario: Comments should exist
    Given the following videos exist
    | name  | description |
    | nom1  | desc1       |
    | nom2  | desc2       |
    | nom3  | desc3       |
    When I am on the video listing page
    Then I should see "desc1"
    And I should see "desc2"
    And I should see "desc3"