require 'spec_helper'

describe SlugService do

  describe '#generate' do
    let(:name) { "I'm the best NAME -- Ever.!?" }
    subject { described_class.generate(name) }

    it 'should snake-case the name' do
      expect(subject).to eq 'im_the_best_name_ever'
    end

    context 'long name' do
      let(:name) { 'X' * 200 }

      it 'should limit the string to 40 chars' do
        expect(subject).to eq('x' * 40)
      end
    end

    context '1 other trade request already has this slug' do
      let!(:trade_request) { create :trade_request, slug: 'im_the_best_name_ever' }

      it 'should append a number to the name' do
        expect(subject).to eq 'im_the_best_name_ever_1'
      end
    end

    context '3 other trade request already has this slug' do
      let!(:trade_request_1) { create :trade_request, slug: 'im_the_best_name_ever' }
      let!(:trade_request_2) { create :trade_request, slug: 'im_the_best_name_ever_1' }
      let!(:trade_request_3) { create :trade_request, slug: 'im_the_best_name_ever_2' }

      it 'should append a number to the name' do
        expect(subject).to eq 'im_the_best_name_ever_3'
      end
    end
  end
end
