module ExchangeRateService extend self

  def current_price
    external_data['ticker']['price'].to_f.round(2)
  end

  private

  def external_data
    data = Rails.cache.fetch(:price_data, expires_in: 5.minutes) do
      connection.get('/api/ticker/dash-usd').body
    end
    JSON.parse data
  end

  def connection
    Faraday.new(url: 'https://api.cryptonator.com')
  end
end
