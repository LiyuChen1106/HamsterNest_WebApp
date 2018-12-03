Feature: Lend item
    I signed in.
    I lend an item.

    Scenario: I successfully lend a book
        Given I am signed in
        Then I create a new book
        Then I post the book
