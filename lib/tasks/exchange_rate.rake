namespace :exchange_rate do

  desc "fetch and cache current exchange rate"
  task update: :environment do
    ExchangeRateService.current_price
  end

end
