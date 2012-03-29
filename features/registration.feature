Feature: Registration
  As a user
  I want to register
  So that I can create a micropost

  Scenario: Successful registration
    Given I have opened the homepage
    When I click on the 'sign-up' button
    Then I should see the registration page
    When I fill in the name with 'andy'
    And I fill in the email with 'andy@example.com'
    And I fill in the password with 'p4$$wd'
    And I fill in the confirmation with 'p4$$wd'
    And I click the create my account button
    Then I should see the message 'Welcome to the Sample App!'
    And I should see my username as 'andy'

  Scenario Outline: Invalid details
    Given I have opened the homepage
    When I click on the 'sign-up' button
    Then I should see the registration page
    When I fill in the name with <name>
    And I fill in the email with <email>
    And I fill in the password with <password>
    And I fill in the confirmation with <confirmation>
    And I click the create my account button
    Then I should see the form has <number> errors
    Then I should see the <messages>

  Examples:
      | name | email            | password | confirmation | number | messages                                                                                                                                                                           |
      |      |                  |          |              |   6    | * Password can't be blank * Name can't be blank * Email can't be blank * Email is invalid * Password is too short (minimum is 6 characters) * Password confirmation can't be blank |
      | andy | andy             |          |              |   5    | * Password can't be blank * Email is invalid * Password is too short (minimum is 6 characters) * Password confirmation can't be blank                                              |
      | andy | andy@example.com |          |              |   3    | * Password can't be blank * Password is too short (minimum is 6 characters) * Password confirmation can't be blank                                                                 |
      | andy | andy@example.com | abcde    |              |   3    | * Password doesn't match confirmation * Password is too short (minimum is 6 characters) * Password confirmation can't be blank                                                     |
      | andy | andy@example.com | abcde    | abcde        |   1    | * Password is too short (minimum is 6 characters)                                                                                                                                  |

  Scenario: Username already exists
    Given a user with the name 'andy' exists
    And I have opened the homepage
    When I click on the 'sign-up' button
    Then I should see the registration page
    When I fill in the name with 'andy'
    And I fill in the email with 'andy@example.com'
    And I fill in the password with 'p4$$wd'
    And I fill in the confirmation with 'p4$$wd'
    And I click the create my account button
    Then I should see the form has one error
    And I should see the message 'Email has already been taken'
