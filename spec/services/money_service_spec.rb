require 'spec_helper'

describe MoneyService do
  describe '#format' do
    let(:currency) { 'usd' }

    subject { described_class.format(10,currency) }

    context 'usd' do
      it 'should format the money' do
        expect(subject).to eq "$10.00"
      end
    end

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

    context 'chf' do
      let(:currency) { 'chf' }

      it 'should format the money' do
        expect(subject).to eq "10.00 Fr."
      end
    end

    context 'cny' do
      let(:currency) { 'cny' }

      it 'should format the money' do
        expect(subject).to eq "¥10.00"
      end
    end

    context 'czk' do
      let(:currency) { 'czk' }

      it 'should format the money' do
        expect(subject).to eq "10.00 Kč"
      end
    end

    context 'dkk' do
      let(:currency) { 'dkk' }

      it 'should format the money' do
        expect(subject).to eq "10.00 kr"
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

    context 'kes' do
      let(:currency) { 'kes' }

      it 'should format the money' do
        expect(subject).to eq "10.00 KSh"
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
        expect(subject).to eq "10.00 zł"
      end
    end

    context 'rub' do
      let(:currency) { 'rub' }

      it 'should format the money' do
        expect(subject).to eq "10.00 ₽"
      end
    end

    context 'sek' do
      let(:currency) { 'sek' }

      it 'should format the money' do
        expect(subject).to eq "10.00 kr"
      end
    end

    context 'tzs' do
      let(:currency) { 'tzs' }

      it 'should format the money' do
        expect(subject).to eq "10.00 TSh"
      end
    end

    context 'large numbers' do
      subject { described_class.format(1000,currency) }

      context 'usd' do
        it 'it should omit decimals on large numbers' do
          expect(subject).to eq "$1000"
        end
      end

      context 'tzs' do
        let(:currency) { 'tzs' }

        it 'should format the money' do
          expect(subject).to eq "1000 TSh"
        end
      end
    end
  end
end
