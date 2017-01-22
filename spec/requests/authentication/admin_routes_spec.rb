require 'spec_helper'

RSpec.describe 'Admin Routes', type: :request do
  let!(:user) { create :user, username: 'Bob', email: email }
  let(:email) { 'some@email.com' }

  before do
    ActionController::Base.allow_forgery_protection = false
  end

  after do
    ActionController::Base.allow_forgery_protection = true
  end

  context 'resque' do
    subject { get '/resque' }

    context 'not authenticated' do
      it 'should return an error' do
        expect {subject}.to raise_error(ActionController::RoutingError)
      end
    end

    context 'authenticated' do
      before do
        ActionController::Base.allow_forgery_protection = false
        post '/login', params: { user: { username: 'Bob', password: 'password'} }
      end

      it 'should return an error' do
        expect {subject}.to raise_error(ActionController::RoutingError)
      end

      context 'as admin' do
        let(:email) { Settings.admin.email }

        it 'should return an error' do
          expect {subject}.not_to raise_error
          expect(response.status).to eq 302
        end
      end
    end
  end
end
