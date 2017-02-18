require 'spec_helper'

RSpec.describe NotificationMailer, type: :mailer do
  let!(:user1) { create :user, username: 'Bob', email: 'bob@email.com' }
  let!(:user2) { create :user, username: 'Ken', email: 'ken@email.com' }
  let!(:trade_request) { create :trade_request, :new_york, user: user1 }
  let(:offer) { create :offer, user: user2, trade_request: trade_request }
  let(:body) { Capybara::Node::Simple.new(mail.body.to_s) }

  describe 'offer_created' do
    let(:mail) { NotificationMailer.offer_created(offer.id) }

    it 'renders the headers' do
      expect(mail.subject).to eq('You have a new Offer!')
      expect(mail.to).to eq(['bob@email.com'])
      expect(mail.from).to eq([Settings.admin.email])
    end

    it 'renders the body' do
      expect(body).to have_content 'See your new offer on your trade requests page:'
      expect(body).to have_link(
        "http://127.0.0.1:52010/u/trade_requests?expand=#{trade_request.id}",
        href: "http://127.0.0.1:52010/u/trade_requests?expand=#{trade_request.id}"
      )
    end
  end

  describe 'offer_approved' do
    let(:mail) { NotificationMailer.offer_approved(offer.id) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Your Offer has been Approved!')
      expect(mail.to).to eq(['ken@email.com'])
      expect(mail.from).to eq([Settings.admin.email])
    end

    it 'renders the body' do
      expect(body).to have_content 'See your offers on the offers page:'
      expect(body).to have_link(
        'http://127.0.0.1:52010/u/offers',
        href: 'http://127.0.0.1:52010/u/offers'
      )
    end
  end
end
