Feature: Registration
  As Andy (someone curious about microblogging)
  I want to register
  So that I can explore this microblogging phenomenon

  Background: Andy has decided to register
    Given I have started registration
    And I find this advice helpful
      | Problem                     | Advice                                            |
      | blank password              | * Password can't be blank                         |
      | blank name                  | * Name can't be blank                             |
      | blank email                 | * Email can't be blank                            | 
      | invalid email               | * Email is invalid                                |
      | short password              | * Password is too short (minimum is 6 characters) |
      | blank password confirmation | * Password confirmation can't be blank            |
      | mismatched password         | * Password doesn't match confirmation             | 
      | unavailable user id         | * Email has already been taken                    | 

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
    Then I should be advised on how to deal with these <problems>

    Examples: of common registration problems
      | name | email              | password | confirmation |  problems                                                                                                                                                                           |
      |      |                    |          |              |  blank password, blank name, blank email, invalid email, short password, blank password confirmation |
      | Andy | andy               |          |              |  blank password, invalid email, short password, blank password confirmation                          |
      | Andy | andy@example.com   |          |              |  blank password, short password, blank password confirmation                                         |
      | Andy | andy@example.com   | abcde    |              |  mismatched password, short password, blank password confirmation                                    |
      | Andy | andy@example.com   | abcde    | abcde        |  short password                                                                                      |
      | Andy | andrew@example.com | abcdef   | abcdef       |  unavailable user id                                                                                 |
