require 'feature_helper'

feature 'my trade requests are listed correctly', js: true do
  given!(:user1) { create :user }
  given!(:user2) { create :user }
  given!(:trade_request1) do
    create :trade_request, :new_york,
      user: user1,
      name: 'My Trade'
  end
  given!(:trade_request2) do
    create :trade_request, :new_york,
      user: user2,
      name: "Another Guy's Trade"
  end

  context 'authenticated' do
    background do
      login_as user1
    end

    Steps 'I view my trade requests' do
      Given 'I am on the trade requests page' do
        should_be_located '/u/trade_requests'
      end
      Then 'I should see my trade request' do
        should_see 'My Trade'
      end
      And "I should not see other people's trade requests" do
        should_not_see "Another Guy's Trade"
      end
      When 'I click the view link' do
        find('.actions .fa-cog').click
        click_link 'View'
      end
      Then 'I should be on the public page' do
        within 'h1' do
          should_see 'My Trade'
        end
        should_be_located public_trade_request_path(trade_request1.slug)
      end
    end
  end
end

