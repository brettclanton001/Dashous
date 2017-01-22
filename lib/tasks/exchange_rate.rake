namespace :exchange_rate do

  desc "fetch and cache current exchange rate"
  task update: :environment do
    ExchangeRateService.send :fetch_external_data
  end
end
