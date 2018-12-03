Feature: Visit homepage
    Scenario: See hompage
        Given I am on the homepage
        Then I should see the welcome message
        When I click About us
        Then I should see About us
        When I click Terms of Service
        Then I should see Terms of Service
        When I click Privacy Policy
        Then I should see Privacy Policy