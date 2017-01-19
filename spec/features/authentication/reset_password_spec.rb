require 'feature_helper'

feature 'reset password', js: true do
  given!(:user) { create :user, username: 'luiswong' }

  Steps 'for requesting reset instructions' do
    When 'I visit the homepage' do
      visit '/'
    end
    And 'I click on Login' do
      within '.nav' do
        click_link 'Login'
      end
    end
    And 'I ask for reset instructions' do
      click_link 'Forgot your password?'
    end
    And 'I fill in my username' do
      fill_in :user_username, with: 'luiswong'
      expect(find_field('user[username]').value).to eq 'luiswong'
    end
    And 'I submit the form' do
      click_button 'Send me reset password instructions'
    end
    Then 'An email should be sent' do
      should_see 'You will receive an email with instructions on how to reset your password in a few minutes.'
    end
    And 'the user should have a reset password token' do
      expect(user.reload.reset_password_token).to_not be_empty
    end
    When 'I visit the reset password url' do
      open_email(user.email)
      current_email.click_link 'Change my password'
    end
    Then 'I see the change password form' do
      within 'h1' do
        should_see 'Change your password'
      end
    end
    And 'There is no error about the reset token' do
      should_not_see 'Reset password token is invalid'
    end
    When 'I fill out the form' do
      fill_in :user_password, with: 'abcdef'
      fill_in :user_password_confirmation, with: 'abcdef'
    end
    And 'I submit the form' do
      click_button 'Change my password'
    end
    Then 'should see success message' do
      should_see 'Your password has been changed successfully. You are now signed in.'
    end
  end
end
