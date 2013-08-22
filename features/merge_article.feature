 Feature: Merge Articles
   As a blog administrator
   In order to compact users'' article within my blog
   I want to be able to merge two articles into one
 
   Background:
     Given the blog is set up with two users admin and non-admin
     And the following articles exist:
     | title     | body           | user_id | published | 
     | Article 1 | Article text 1 | 1       | true | 
     | Article 2 | Article text 2 | 1       | true | 
     | Article 3 | Article text 3 | 2       | true | 
 
   Scenario: A non-admin cannot merge two articles
      Given I am logged into the admin panel as "non-admin"
      When  I go to the admin content edit page for "Article 3"
      Then  I should not see the section "Merge Articles"
      When  I go to the admin content page
      And   I follow "Article 2"
      Then  I should see "Error, you are not allowed to perform this action"
 
   Scenario: When articles are merged, the article id to be merged should be different from the current id
     Given  I am logged into the admin panel as "admin"
      And   I am on the admin content edit page for "Article 2" 
      When  I fill in "merge_with" with "2"
     And    I press "Merge"
     Then   I should see "The Article ID cannot be found or is not valid"
 
   Scenario: When articles are merged, the article id to be merged should refer to an existing Article
    Given  I am logged into the admin panel as "admin"
      And  I am on the admin content edit page for "Article 1" 
     When  I fill in "merge_with" with "9"
     And   I press "Merge"
     Then  I should see "The Article ID cannot be found or is not valid"
 
   Scenario: When articles are merged, the merged article should contain the text of both previous articles (admin user)
     Given I am logged into the admin panel as "admin"
     And   I am on the admin content edit page for "Article 1" 
     Then  I should see the section "Merge Articles"
     When  I fill in "merge_with" with "2"
     And   I press "Merge"
     Then  I should be on the admin content edit page for "Article 1"
     Then  I should see "Article text 1"
     And   The "article_title" field should be "Article 1"
     #And   I should see "Article text 2"
     When  I go to the admin content index page
     #Then  I should not see "Article 2"
 
 
 
 
 
 
