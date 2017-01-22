require 'spec_helper'

describe MoneyService do
  describe '#format' do
    subject { described_class.format(10,currency) }

    context 'gbp' do
      let(:currency) { 'gbp' }

      it 'should format the money' do
        expect(subject).to eq "£10.00"
      end
    end

    context 'cad' do
      let(:currency) { 'cad' }

      it 'should format the money' do
        expect(subject).to eq "$10.00"
      end
    end

    context 'cny' do
      let(:currency) { 'cny' }

      it 'should format the money' do
        expect(subject).to eq "¥10.00"
      end
    end

    context 'eur' do
      let(:currency) { 'eur' }

      it 'should format the money' do
        expect(subject).to eq "€10.00"
      end
    end

    context 'jpy' do
      let(:currency) { 'jpy' }

      it 'should format the money' do
        expect(subject).to eq "¥10.00"
      end
    end

    context 'myr' do
      let(:currency) { 'myr' }

      it 'should format the money' do
        expect(subject).to eq "RM10.00"
      end
    end

    context 'pln' do
      let(:currency) { 'pln' }

      it 'should format the money' do
        expect(subject).to eq "zł10.00"
      end
    end

    context 'rub' do
      let(:currency) { 'rub' }

      it 'should format the money' do
        expect(subject).to eq "₽10.00"
      end
    end

    context 'usd' do
      let(:currency) { 'usd' }

      it 'should format the money' do
        expect(subject).to eq "$10.00"
      end
    end
  end
end
