require 'feature_helper'

feature 'my trade requests are editable', js: true do
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

    Steps 'I edit my trade request' do
      Given 'I am on the trade requests page' do
        should_be_located '/u/trade_requests'
      end
      Then 'I should see my trade request' do
        should_see 'My Trade'
      end
      And 'I should not see the action options' do
        within '.table-list .row:first-child' do
          should_not_see 'Edit'
        end
      end
      When 'I click the gear for the trade request' do
        within '.table-list .row:first-child' do
          find('.fa-cog').click
        end
      end
      Then 'I should see the action options' do
        within '.table-list .row:first-child' do
          should_see 'Edit'
        end
      end
      When 'I click the link to edit' do
        within '.table-list .row:first-child' do
          click_link 'Edit'
        end
      end
      Then 'I see the editing form' do
        should_see 'Edit Trade Request'
        should_be_located edit_trade_request_path(trade_request1.id)
      end
      When 'I change the name' do
        fill_in :trade_request_name, with: 'My Updated Trade'
      end
      And 'I click save' do
        click_button 'Save'
      end
      Then 'I should see my updated trade request' do
        should_see 'My Updated Trade'
        should_not_see 'My Trade'
      end
    end

    Steps 'I edit the trade request to have invalid data' do
      Given 'I am on the trade requests page' do
        should_be_located '/u/trade_requests'
      end
      When 'I click the link to edit' do
        within '.table-list .row:first-child' do
          find('.fa-cog').click
          click_link 'Edit'
        end
      end
      And 'I change the name' do
        fill_in :trade_request_name, with: ''
      end
      And 'I click save' do
        click_button 'Save'
      end
      Then 'I should still be on the edit form' do
        should_see 'Edit Trade Request'
        should_see "Name can't be blank"
      end
      When 'I change the name' do
        fill_in :trade_request_name, with: 'My Updated Trade'
      end
      And 'I click save' do
        click_button 'Save'
      end
      Then 'I should see my updated trade request' do
        should_see 'My Updated Trade'
        should_not_see 'My Trade'
      end
    end

    Steps 'I cancel my edits' do
      Given 'I am on the trade requests page' do
        should_be_located '/u/trade_requests'
      end
      When 'I click the link to edit' do
        within '.table-list .row:first-child' do
          find('.fa-cog').click
          click_link 'Edit'
        end
      end
      And 'I change the name' do
        fill_in :trade_request_name, with: 'My Updated Trade'
      end
      And 'I click cancel' do
        click_link 'Cancel'
      end
      Then 'I should not see an updated trade request' do
        should_see 'My Trade'
        should_not_see 'My Updated Trade'
      end
    end

    Steps 'I attempt to edit a trade request that belongs to another user' do
      When 'I navigate directly to the edit page' do
        visit edit_trade_request_path(trade_request2.id)
      end
      Then 'I should be redirected to the trade requests list page' do
        within '.content' do
          should_see 'Trade Requests'
        end
        should_be_located trade_requests_path
      end
      And 'I should not be on the edit form' do
        should_not_see 'Edit Trade Request'
      end
    end
  end
end

