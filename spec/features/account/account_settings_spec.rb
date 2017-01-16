require 'feature_helper'

feature 'account settings', js: true do
  given!(:user) { create :user }

  background do
    stub_price(10)
    login_as user
  end

  Steps 'I change my currency setting' do
    When 'I visit the account settings page' do
      visit account_path
    end
    Then 'I should see the currently set currency' do
      expect(page).to have_select('user_currency', selected: 'USD')
    end
    When 'I set it to EUR' do
      select "EUR", from: "user_currency"
    end
    And 'I submit the form' do
      click_button 'Update'
    end
    Then 'I should see a success message' do
      should_see 'Account Updated'
    end
    And 'my currency should be in euros' do
      should_see '€10.00'
    end
    When 'I visit the homepage' do
      visit root_path
    end
    And 'my currency should be in euros' do
      should_see '€10.00'
    end
  end
end
