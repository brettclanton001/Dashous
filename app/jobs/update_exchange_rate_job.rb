class UpdateExchangeRateJob < ApplicationJob
  queue_as :exchange_rate

  def perform(*args)
    ExchangeRateService.send :fetch_external_data
  end
end
