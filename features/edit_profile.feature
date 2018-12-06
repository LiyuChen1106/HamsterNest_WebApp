Feature: I edit profile
    Scenario: I successfully edit profile        
        Given I am on Signup page
        Then I fill in without error
        Then I confirm
        Then I sign in
        Then I edit profile