require 'spec_helper'

RSpec.describe 'Creating Offers', type: :request do
  let!(:user1) { create :user, username: 'Bob', email: 'bob@email.com' }
  let!(:user2) { create :user, username: 'Ken', email: 'ken@email.com' }
  let!(:trade_request) do
    create :trade_request, :new_york,
      user: user2,
      name: 'My Trade',
      kind: 'sell',
      profit: '12'
  end
  let(:data) do
    {
      offer: {
        trade_request_id: trade_request.id
      }
    }
  end

  subject { post '/u/offers', params: data }

  before do
    ActionController::Base.allow_forgery_protection = false
    post '/login', params: { user: { username: 'Bob', password: 'password'} }
  end

  after do
    ActionController::Base.allow_forgery_protection = true
  end

  it 'should succeed to create a valid offer' do
    expect { subject }.to change { Offer.count }.from(0).to(1)
  end

  it 'should return a success flash message on creating an offer' do
    subject
    expect(flash[:notice]).to eq 'Offer successfully created. Please wait for a reply.'
  end

  context 'I own the trade request' do
    let!(:trade_request) do
      create :trade_request, :new_york,
        user: user1,
        name: 'My Trade',
        kind: 'sell',
        profit: '12'
    end

    it 'should fail to create a valid offer' do
      expect { subject }.not_to change { Offer.count }.from(0)
    end

    it 'should return an error flash message on creating an offer' do
      subject
      expect(flash[:alert]).to eq 'Offer failed to create.'
    end
  end

  context 'I have a previous pending offer' do
    let!(:offer) { create :offer, user: user1, trade_request: trade_request, status: :pending }

    it 'should fail to create a valid offer' do
      expect { subject }.not_to change { Offer.count }.from(1)
    end

    it 'should return an error flash message on creating an offer' do
      subject
      expect(flash[:alert]).to eq 'Offer failed to create.'
    end
  end

  context 'I have a previous declined offer' do
    let!(:offer) { create :offer, user: user1, trade_request: trade_request, status: :declined }

    it 'should fail to create a valid offer' do
      expect { subject }.not_to change { Offer.count }.from(1)
    end

    it 'should return an error flash message on creating an offer' do
      subject
      expect(flash[:alert]).to eq 'Offer failed to create.'
    end
  end
end
