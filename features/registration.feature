Feature: Registration
  As a user
  I want to register
  So that I can create a micropost

  Scenario: Successful registration
    Given I have started registration
    #Given I have opened the homepage
    #When I click on the 'sign-up' button
    #Then I should see the registration page
    
    When I complete registration with the following:
      | Field        | Value             |
      | name         | Andy              |
      | email        | andy@example.com  |
      | password     | p4$$wd            |
      | confirmation | p4$$wd            |

      #When I fill in the name with 'andy'
      #And I fill in the email with 'andy@example.com'
      #And I fill in the password with 'p4$$wd'
      #And I fill in the confirmation with 'p4$$wd'
      #And I click the create my account button

    Then I should see that I am registered
    #Then I should see the message 'Welcome to the Sample App!'
    #And I should see my username as 'andy'

  Scenario Outline: Invalid details
    Given I have started registration
    #Given I have opened the homepage
    #When I click on the 'sign-up' button
    #Then I should see the registration page
    When I complete registration with the following:
      | Field        | Value             |
      | name         | <name>            |
      | email        | <email>           |
      | password     | <password>        |
      | confirmation | <confirmation>    |

      #When I fill in the name with <name>
      #And I fill in the email with <email>
      #And I fill in the password with <password>
      #And I fill in the confirmation with <confirmation>
      #And I click the create my account button

    Then I should see these registration error <messages>
    #Then I should see the form has <number> errors
    #Then I should see the <messages>

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
      #And I have opened the homepage
      #When I click on the 'sign-up' button
      #Then I should see the registration page

    When I complete registration with the following:
      | Field        | Value             |
      | name         | Andy              |
      | email        | andy@example.com  |
      | password     | p4$$wd            |
      | confirmation | p4$$wd            |
      #When I fill in the name with 'andy'
      #And I fill in the email with 'andy@example.com'
      #And I fill in the password with 'p4$$wd'
      #And I fill in the confirmation with 'p4$$wd'
      #And I click the create my account button

    Then I should see the registration error '* Email has already been taken'
    #Then I should see the form has one error
    #And I should see the message 'Email has already been taken'
