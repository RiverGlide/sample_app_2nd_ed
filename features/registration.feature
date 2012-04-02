Feature: Registration
  As Andy (someone curious about microblogging)
  I want to register
  So that I can explore this microblogging phenomenon

  Background: Andy has decided to register
    Given I have started registration

  Scenario: Register successfully
    When I complete registration with the following:
      | Field                 | Value             |
      | name                  | Andy              |
      | email                 | andy@example.com  |
      | password              | p4$$wd            |
      | password confirmation | p4$$wd            |
    Then I should see that I am registered

  Scenario Outline: Receive advice about registration problems
    Given a user with the email 'andrew@example.com' exists
    When I complete registration with the following:
      | Field                 | Value             |
      | name                  | <name>            |
      | email                 | <email>           |
      | password              | <password>        |
      | password confirmation | <confirmation>    |
    Then I should see these registration error '<messages>'

  Examples: of common registration problems
      | name | email              | password | confirmation |  messages                                                                                                                                                                           |
      |      |                    |          |              |  * Password can't be blank * Name can't be blank * Email can't be blank * Email is invalid * Password is too short (minimum is 6 characters) * Password confirmation can't be blank |
      | andy | andy               |          |              |  * Password can't be blank * Email is invalid * Password is too short (minimum is 6 characters) * Password confirmation can't be blank                                              |
      | andy | andy@example.com   |          |              |  * Password can't be blank * Password is too short (minimum is 6 characters) * Password confirmation can't be blank                                                                 |
      | andy | andy@example.com   | abcde    |              |  * Password doesn't match confirmation * Password is too short (minimum is 6 characters) * Password confirmation can't be blank                                                     |
      | andy | andy@example.com   | abcde    | abcde        |  * Password is too short (minimum is 6 characters)                                                                                                                                  |
      | andy | andrew@example.com | abcdef   | abcdef       |  * Email has already been taken                                                                                                                                                     |
