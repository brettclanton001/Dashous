class UpdateExchangeRateJob < ApplicationJob
  queue_as :exchange_rate

  def perform(*args)
    ExchangeRateService.fetch_external_data
  end
end
