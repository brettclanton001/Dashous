require 'spec_helper'

RSpec.describe 'Enforce Domain', type: :request do
  let(:domain) { '127.0.0.1' }

  context 'homepage' do
    subject { get "http://#{domain}/" }

    it 'should return success' do
      subject
      expect(response.status).to eq 200
    end

    context 'wrong domain' do
      let(:domain) { 'www.example.com' }

      it 'should redirect' do
        subject
        expect(response.status).to eq 301
      end
    end
  end
end
