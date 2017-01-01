require 'feature_helper'

feature 'View a Trade Request', js: true do
  given!(:user1) { create :user, username: 'Bob', email: 'bob@email.com' }
  given!(:user2) { create :user, username: 'Ken', email: 'ken@email.com' }
  given!(:trade_request1) do
    create :trade_request, :new_york,
      user: user1,
      name: 'My Trade',
      kind: 'sell',
      profit: '12'
  end
  given!(:trade_request2) do
    create :trade_request, :stamford,
      user: user2,
      name: "Another Guy's Trade",
      kind: 'sell',
      profit: '12'
  end
  given(:offer) { user1.offers.last }
  given!(:current_price) { stub_price(10) }

  Steps 'I visit the wrong page' do
    When 'I visit the profile url' do
      visit '/t/typotypo'
    end
    Then 'I should see the 404 page' do
      should_see '404 This page was not found.'
    end
    When 'when I click the link to return to the homepage' do
      click_link 'Return to Homepage'
    end
    Then 'I should be on the homepage' do
      should_see 'Search Results'
      should_be_located root_path
    end
  end
end
