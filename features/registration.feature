Feature: Registration
  As a user
  I want to register
  So that I can create a micropost

  Scenario: Successful registration
    Given I have started registration
    When I complete registration with the following:
      | Field        | Value             |
      | name         | Andy              |
      | email        | andy@example.com  |
      | password     | p4$$wd            |
      | confirmation | p4$$wd            |
    Then I should see that I am registered

  Scenario Outline: Invalid details
    Given I have started registration
    When I complete registration with the following:
      | Field        | Value             |
      | name         | <name>            |
      | email        | <email>           |
      | password     | <password>        |
      | confirmation | <confirmation>    |
    Then I should see these registration error <messages>

  Examples:
      | name | email            | password | confirmation |  messages                                                                                                                                                                           |
      |      |                  |          |              |  * Password can't be blank * Name can't be blank * Email can't be blank * Email is invalid * Password is too short (minimum is 6 characters) * Password confirmation can't be blank |
      | andy | andy             |          |              |  * Password can't be blank * Email is invalid * Password is too short (minimum is 6 characters) * Password confirmation can't be blank                                              |
      | andy | andy@example.com |          |              |  * Password can't be blank * Password is too short (minimum is 6 characters) * Password confirmation can't be blank                                                                 |
      | andy | andy@example.com | abcde    |              |  * Password doesn't match confirmation * Password is too short (minimum is 6 characters) * Password confirmation can't be blank                                                     |
      | andy | andy@example.com | abcde    | abcde        |  * Password is too short (minimum is 6 characters)                                                                                                                                  |

  Scenario: Username already exists
    Given a user with the email 'andy@example.com' exists
    And I have started registration
    When I complete registration with the following:
      | Field        | Value             |
      | name         | Andy              |
      | email        | andy@example.com  |
      | password     | p4$$wd            |
      | confirmation | p4$$wd            |
    Then I should see the registration error '* Email has already been taken'
