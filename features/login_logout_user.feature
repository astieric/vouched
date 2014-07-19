Feature: Login Log out user
  In order to log in 
  As an unregistered user
  I want to log in

  @javascript 
  Scenario: Login as user
    Given I have one user "username@username.com" with password "passwd1" and login "username_test"
    When I go to the homepage
    When I follow "Login"
    Then I should see "Sign in to your account."
    When I fill in "user_username" with "username_test" within "form[@id='user_login']"
    And I fill in "user_password" with "passwd1" within "form[@id='user_login']"
    And I press "Login"
    Then I should see "Confirm your Identities to start collecting vouches"
