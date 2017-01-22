require 'feature_helper'

feature 'Signup', js: true do
  given(:user) { User.last }

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
        should_see 'Password * (6 characters minimum)'
        should_see 'Password Confirmation *'
      end
    end
    When 'I submit the form' do
      click_button 'Signup'
    end
    Then 'I should see validation errors' do
      within '.content' do
        should_see "Email can't be blank"
        should_see "Username can't be blank"
        should_see 'Username is invalid'
        should_see "Password can't be blank"
        should_see "Password confirmation can't be blank"
        should_see 'Terms and conditions must be accepted'
      end
    end
    When 'I fill out and submit the form' do
      fill_in :user_email, with: 'test@example.com'
      fill_in :user_username, with: 'John Doe'
      fill_in :user_password, with: '123456'
      fill_in :user_password_confirmation, with: '123456'
    end
    And 'I submit the form' do
      click_button 'Signup'
    end
    And 'I enter in a valid username' do
      fill_in :user_username, with: 'JohnDoe'
    end
    And 'I submit the form' do
      click_button 'Signup'
    end
    Then 'I should see validation errors' do
      within '.content' do
        should_not_see "Email can't be blank"
        should_not_see "Username can't be blank"
        should_not_see 'Username is invalid'
        should_see 'Terms and conditions must be accepted'
        expect(find_field('user[password]').value).to eq ''
        expect(find_field('user[password_confirmation]').value).to eq ''
      end
    end
    When 'I accept the terms and conditions and re-enter the password' do
      check 'I accept the terms and conditions *'
      fill_in :user_password, with: '123456'
      fill_in :user_password_confirmation, with: '123456'
    end
    And 'I submit the form' do
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
    And 'The user should be created' do
      expect(user).to be_present
      expect(user.username).to eq 'JohnDoe'
      expect(user.currency).to eq 'usd'
    end
    When 'I visit the link' do
      visit "/u/confirmation?confirmation_token=#{user.confirmation_token}"
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

  Steps 'a new user signs up but has to resend the confirmation email' do
    When 'I visit the signup page' do
      visit '/signup'
    end
    When 'I fill out and submit the form' do
      fill_in :user_email, with: 'test@example.com'
      fill_in :user_username, with: 'JohnDoe'
      fill_in :user_password, with: '123456'
      fill_in :user_password_confirmation, with: '123456'
      check 'I accept the terms and conditions *'
    end
    And 'I submit the form' do
      click_button 'Signup'
    end
    Then 'I should see a message about checking my email' do
      should_see 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
    end
    When 'I go to the login page' do
      visit '/login'
    end
    And 'I try to act like I did not receive an email' do
      click_link "Didn't receive confirmation instructions?"
    end
    Then 'I should see the resend confirmation page' do
      within 'h1' do
        should_see 'Resend confirmation instructions'
      end
    end
    When 'I enter in my username' do
      fill_in :user_username, with: 'JohnDoe'
    end
    And 'I submit the form' do
      click_button 'Resend confirmation instructions'
    end
    Then 'I should see a success message' do
      should_see 'You will receive an email with instructions for how to confirm your email address in a few minutes.'
    end
    When 'I visit the link' do
      visit "/u/confirmation?confirmation_token=#{user.reload.confirmation_token}"
    end
    Then 'I should see a success message' do
      should_see 'Your email address has been successfully confirmed.'
    end
    When 'I log in' do
      fill_in :user_username, with: 'JohnDoe'
      fill_in :user_password, with: '123456'
      click_button 'Login'
    end
    Then 'I see the success message' do
      should_see 'Signed in successfully.'
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
      check 'I accept the terms and conditions *'
      click_button 'Signup'
    end
    Then 'I should see a message about checking my email' do
      should_see 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
    end
  end

  Steps 'non-matching passwords' do
    When 'I visit the signup page' do
      visit '/signup'
    end
    And 'I enter in an invalid username' do
      fill_in :user_username, with: 'John Doe'
    end
    When 'I fill out and submit the form' do
      fill_in :user_email, with: 'test@example.com'
      fill_in :user_username, with: 'JohnDoe'
      fill_in :user_password, with: '123456'
      fill_in :user_password_confirmation, with: '654321'
      check 'I accept the terms and conditions *'
      click_button 'Signup'
    end
    Then 'I should see an error' do
      should_see "Password confirmation doesn't match Password"
      should_not_see 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
    end
    When 'I fill out and submit the form' do
      fill_in :user_password, with: '123456'
      fill_in :user_password_confirmation, with: '123456'
      click_button 'Signup'
    end
    Then 'I should see a message about checking my email' do
      should_see 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.'
    end
  end
end
