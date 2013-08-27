 Feature: Manage Categories
   As a blog administrator
   In order to classify articles by category within my blog
   I want to be able to manage article's categories
 
   Background:
     Given the blog is set up with two users admin and non-admin
     And the following articles having categories exist:
     | id | title     | body           | user_id | published | 
     | 1  | Article 1 | Article text 1 | 1       | true      | 
     | 2  | Article 2 | Article text 2 | 1       | true      | 
     | 3  | Article 3 | Article text 3 | 2       | true      | 
     And the following categories exist:
     | id | name     | description | 
     | 10  | General Edx  | General Edx category | 
 

   Scenario: When I access the Category Management page, the list of the available Categories should be displayed
    Given I am logged into the admin panel as "admin"
      And I am on the admin content page
     When I follow "Categories"
     Then I should be on the new categories page
      And I should see "General Edx category"

    Scenario: When I access the Category Management page, a new category should be added
    Given I am logged into the admin panel as "admin"
      And I am on the new categories page
     When I fill in "Name" with "EDX test"
      And I press "Save"
     Then I should be on the new categories page
      And I should see "Category was successfully saved."
      And I should see "General Edx category"



 
 
 
 
