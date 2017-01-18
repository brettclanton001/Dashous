require 'feature_helper'

feature 'reset password', js: true do
  given!(:user) { create :user }

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
      fill_in 'Username', with: user.username
      click_on 'Send me reset password instructions'
    end
    Then 'An email should be sent' do
      should_see 'You will receive an email with instructions'
      user.reload
      expect(user.reset_password_token).to_not be_empty
    end
  end
end
