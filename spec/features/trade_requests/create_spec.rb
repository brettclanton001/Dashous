require 'feature_helper'

feature 'Create trade request', js: true do
  given(:user) { create :user }

  context 'authenticated' do
    background do
      login_as user
    end

    Steps 'I create my first trade request' do
      Given 'I am on the trade requests page' do
        should_be_located '/u/trade_requests'
      end
      When 'I click the create button' do
        click_link '+ Create New'
      end
      Then 'I should see the trade request form' do
        should_see 'New Trade Request'
        should_see 'Name'
        should_see 'Location'
        should_see 'Trade Type'
        should_see 'Profit Margin'
        should_be_located '/u/trade_requests/new'
      end
      When 'I click save' do
        click_button 'Save'
      end
      Then 'I should see validation errors' do
        should_see 'New Trade Request'
        should_see "Name can't be blank"
        should_see "Location can't be blank"
      end
      When 'I fill out the form' do
        fill_in :trade_request_name, with: 'Best Trade Ever'
        fill_in :trade_request_location, with: 'Atlanta GA'
        choose :trade_request_kind_sell
        fill_in :trade_request_profit, with: '2.5'
      end
      When 'I click save' do
        click_button 'Save'
      end
      Then 'I should be on the list view' do
        should_see '+ Create New'
      end
    end
  end
end
