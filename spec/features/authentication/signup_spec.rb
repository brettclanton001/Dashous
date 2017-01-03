require 'feature_helper'

feature 'Signup', js: true do

  Steps 'a new user signs up' do
    When 'I visit the homepage' do
      visit '/'
    end
    Then 'I should see links meant for a non-authenticated user' do
      within '.nav' do
        should_see 'Login'
        should_see 'Signup'
        should_not_see 'Offers'
        should_not_see 'Trade Requests'
        should_not_see 'Account'
      end
    end
    When 'I click the Signup link' do
      within '.nav' do
        click_link 'Signup'
      end
    end
    Then 'I should be on the sign up page' do
      within '.content' do
        should_see 'Signup'
        should_see 'Password* (6 characters minimum)'
        should_see 'Password Confirmation*'
      end
    end
    When 'I fill out and submit the form' do
      fill_in :user_email, with: 'test@example.com'
      fill_in :user_username, with: 'JohnDoe'
      fill_in :user_password, with: '123456'
      fill_in :user_password_confirmation, with: '123456'
      click_button 'Signup'
    end
    Then 'I should see a message about checking my email' do
      should_see 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
    end
    And 'I should not be logged in' do
      within '.nav' do
        should_see 'Login'
        should_see 'Signup'
        should_not_see 'Offers'
        should_not_see 'Trade Requests'
        should_not_see 'Account'
      end
    end
    When 'I visit the link' do
      visit "/users/confirmation?confirmation_token=#{User.last.confirmation_token}"
    end
    Then 'I should see a success message' do
      should_see 'Your email address has been successfully confirmed.'
    end
    And 'I should not be logged in' do
      within '.nav' do
        should_see 'Login'
        should_see 'Signup'
        should_not_see 'Offers'
        should_not_see 'Trade Requests'
        should_not_see 'Account'
      end
    end
    When 'I log in' do
      fill_in :user_username, with: 'JohnDoe'
      fill_in :user_password, with: '123456'
      click_button 'Login'
    end
    Then 'I see the success message' do
      should_see 'Signed in successfully.'
    end
    And 'I should see links meant for an internal account' do
      within '.nav' do
        should_not_see 'Login'
        should_not_see 'Signup'
        should_see 'Offers'
        should_see 'Trade Requests'
        should_see 'Account'
      end
    end
  end

  Steps 'invalid usernames' do
    When 'I visit the signup page' do
      visit '/signup'
    end
    And 'I enter in an invalid username' do
      fill_in :user_username, with: 'John Doe'
    end
    And 'I click submit' do
      click_button 'Signup'
    end
    Then 'I should see an error' do
      should_see 'Username is invalid'
    end
    When 'I fill out and submit the form' do
      fill_in :user_email, with: 'test@example.com'
      fill_in :user_username, with: 'JohnDoe'
      fill_in :user_password, with: '123456'
      fill_in :user_password_confirmation, with: '123456'
      click_button 'Signup'
    end
    Then 'I should see a message about checking my email' do
      should_see 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
    end
  end
end
