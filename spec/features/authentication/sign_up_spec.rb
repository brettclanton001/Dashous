require 'feature_helper'

feature 'Sign Up', js: true do

  Steps 'a new user signs up' do
    When 'I visit the homepage' do
      visit '/'
    end
    Then 'I should see links meant for a non-authenticated user' do
      within '.nav' do
        should_see 'Login'
        should_see 'Sign Up'
        should_not_see 'Offers'
        should_not_see 'Trade Requests'
        should_not_see 'Account'
        should_not_see 'Logout'
      end
    end
    When 'I click the Sign Up link' do
      click_link 'Sign Up'
    end
    Then 'I should be on the sign up page' do
      within '.content' do
        should_see 'Sign up'
        should_see 'Password (6 characters minimum)'
        should_see 'Password confirmation'
      end
    end
    When 'I fill out and submit the form' do
      fill_in :user_email, with: 'test@example.com'
      fill_in :user_password, with: '123456'
      fill_in :user_password_confirmation, with: '123456'
      click_button 'Sign up'
    end
    Then 'I should see links meant for an internal account' do
      within '.nav' do
        should_not_see 'Login'
        should_not_see 'Sign Up'
        should_see 'Offers'
        should_see 'Trade Requests'
        should_see 'Account'
        should_see 'Logout'
      end
    end
    When 'I log out' do
      click_link 'Logout'
    end
    Then 'I should see links meant for a non-authenticated user' do
      within '.nav' do
        should_see 'Login'
        should_see 'Sign Up'
        should_not_see 'Offers'
        should_not_see 'Trade Requests'
        should_not_see 'Account'
        should_not_see 'Logout'
      end
    end
  end
end
