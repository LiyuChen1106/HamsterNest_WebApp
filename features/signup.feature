Feature: Sign up
    I start with the Signup page.
    I try to sign up.

    Scenario: I successfully signs up
        Given I am on Signup page
        Then I fill in without error
        Then I see successful message

    Scenario: I fill in wrong email
        Given I am on Signup page
        Then I fill in wrong email
        Then I see error message and remain in Signup page

    Scenario: I didn't receive confirmation instruction
        Given I am on Signup page
        Then I click confirmation instruction
        Then I see confirmation instruction page