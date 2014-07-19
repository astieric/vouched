Feature: Register user
  In order to register user
  As an unregistered user
  I want to register

  @javascript 
  Scenario: Register new user
	  When I go to the register page
    When I fill in "Username" with "username1" within "form[@id='user_new']"
    And I fill in "Email" with "username1@gmail.com" within "form[@id='user_new']"
    And I fill in "Password" with "testtest" within "form[@id='user_new']"
    And I fill in "Password confirmation" with "testtest" within "form[@id='user_new']"
    And I press "Sign up"
    Then I should see "Confirm your Identities to start collecting vouches"
