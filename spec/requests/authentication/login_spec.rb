require 'spec_helper'

RSpec.describe 'Login API', type: :request do
  let!(:user) do
    create :user,
      username: 'Bob',
      password: 'Secret1',
      password_confirmation: 'Secret1'
  end
  let(:username) { 'Bob' }
  let(:password) { 'Secret1' }

  subject do
    post 'http://127.0.0.1/api/v1/authentication/sessions', params: {
      user: {
        username: username,
        password: password
      }
    }
  end

  before do
    ActionController::Base.allow_forgery_protection = false
  end

  it 'should return successful response' do
    subject
    expect(response.status).to eq 204
  end

  context 'no password' do
    let(:password) { nil }

    it 'should return unauthorized response' do
      subject
      expect(response.status).to eq 401
    end
  end

  context 'empty password' do
    let(:password) { '' }

    it 'should return unauthorized response' do
      subject
      expect(response.status).to eq 401
    end
  end

  context 'blank password' do
    let(:password) { ' ' }

    it 'should return unauthorized response' do
      subject
      expect(response.status).to eq 401
    end
  end

  context 'wrong password' do
    let(:password) { 'secret1' }

    it 'should return unauthorized response' do
      subject
      expect(response.status).to eq 401
    end
  end

  context 'unknown username' do
    let(:username) { 'bob' }

    it 'should return unauthorized response' do
      subject
      expect(response.status).to eq 401
    end
  end
end
