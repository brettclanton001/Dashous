require 'feature_helper'

feature 'Logout', js: true do
  given(:user) { create :user }

  background do
    login_as user
  end

  Steps 'I logout' do
    Given 'I am logged in' do
      within '.nav' do
        should_see 'Account'
      end
    end
    When 'I go to the account page' do
      click_link 'Account'
    end
    And 'I logout' do
      click_link 'Logout'
    end
    Then 'I should be logged out' do
      should_see 'Signed out successfully'
      within '.nav' do
        should_not_see 'Account'
      end
    end
  end
end
