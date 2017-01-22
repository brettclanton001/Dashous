require 'rails_helper'

RSpec.describe UpdateExchangeRateJob, type: :job do
  subject { described_class.perform_now }

  it 'should update exchange rate data' do
    expect(ExchangeRateService).to receive(:fetch_external_data)
    subject
  end
end
