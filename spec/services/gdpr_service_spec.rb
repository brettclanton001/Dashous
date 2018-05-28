require 'spec_helper'

describe GdprService do
  let(:service) { described_class.new(user, ip) }
  let(:user) { nil }

  describe '#cookies_allowed?' do
    subject { service.cookies_allowed? }

    context 'UK' do
      let(:ip) { '82.1.185.172' }

      it 'should not allow cookies' do
        expect(subject).to eq false
      end

      context 'user is logged in' do
        let(:user) { create :user }

        it 'should allow cookies' do
          expect(subject).to eq true
        end
      end
    end

    context 'US' do
      let(:ip) { '204.48.19.88' }

      it 'should not allow cookies' do
        expect(subject).to eq true
      end
    end
  end
end
