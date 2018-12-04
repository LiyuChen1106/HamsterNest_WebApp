Feature: Lend item
    I signed in.
    I lend an item.

    Scenario: I successfully lend a book
        Given I am on Signup page
        Then I fill in without error
        Then I confirm
        Then I sign in
        Then I create a new book
        Then I see my items
