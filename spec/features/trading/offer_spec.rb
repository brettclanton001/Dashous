require 'feature_helper'

feature 'Make an offer', js: true do
  given!(:user1) { create :user }
  given!(:user2) { create :user }
  given!(:trade_request1) do
    create :trade_request, :new_york,
      user: user1,
      name: 'My Trade'
  end
  given!(:trade_request2) do
    create :trade_request, :stamford,
      user: user2,
      name: "Another Guy's Trade",
      profit: '12'
  end
  given(:offer) { user1.offers.last }

  context 'authenticated' do

    background do
      login_as user1
    end

    Steps 'I make my first offer' do
      When 'I visit the trade request page' do
        visit public_trade_request_path(trade_request2.id)
      end
      Then 'I should see the trade request' do
        within '.content' do
          should_see "Another Guy's Trade"
          should_see 'This person is selling Dash.'
          should_see 'This person wants a 12% profit.'
          should_see 'The trade location is: Stamford'
          should_see 'Make Offer'
        end
      end
      When 'I click the Make Offer button' do
        click_link 'Make Offer'
      end
      Then 'I should see a success message on the same page' do
        should_see 'Offer successfully created. Please wait for a reply.'
        within '.content' do
          should_see "Another Guy's Trade"
          should_see 'This person is selling Dash.'
          should_see 'This person wants a 12% profit.'
          should_see 'The trade location is: Stamford'
          within 'button.disabled' do
            should_see 'Make Offer'
          end
          should_see 'Offer pending...'
        end
      end
      And 'there is an pending offer' do
        expect(offer.status).to eq 'pending'
        expect(offer.trade_request_id).to eq trade_request2.id
      end
      When 'I navigate to my offers list page' do
        within '.nav' do
          click_link 'Offers'
        end
      end
      Then 'I should see this offer' do
        within '.content' do
          should_see 'Offers'
          within '.table-list .row:first-child' do
            should_see "Another Guy's Trade"
            should_see 'pending'
          end
        end
      end
      When 'I click on the trade request name' do
        click_link "Another Guy's Trade"
      end
      Then 'I should see the trade request' do
        should_be_located "/t/#{trade_request2.id}"
        within '.content' do
          should_see "Another Guy's Trade"
          should_see 'This person is selling Dash.'
          should_see 'This person wants a 12% profit.'
          should_see 'The trade location is: Stamford'
          within 'button.disabled' do
            should_see 'Make Offer'
          end
          should_see 'Offer pending...'
        end
      end
    end
  end
end
