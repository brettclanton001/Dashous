module ExchangeRateService extend self

  CURRENCIES = %w(
    usd
    eur
  ).freeze

  CACHE_TIMEOUT = 15.minutes.freeze

  def current_price(currency='usd')
    external_data[currency]
  end

  private

  def external_data
    cache = get_cache
    return cache if cache_valid?(cache)
    data = fetch_external_data
    set_cache(data)
    data
  end

  def fetch_external_data
    data = {}
    CURRENCIES.each do |currency|
      data[currency] = parse_data connection.get("/api/ticker/dash-#{currency}").body
    end
    data['updated_at'] = Time.now
    data
  end

  def parse_data(body)
    data = JSON.parse body
    price = data['ticker']['price']
    price.to_f.round(2)
  end

  def cache_valid?(cache)
    cache.present? and cache['updated_at'] > Time.now - CACHE_TIMEOUT
  end

  def get_cache
    cache = redis.get(:exchange_rate)
    cache = JSON.parse(cache) if cache.present?
    cache
  end

  def set_cache(data)
    redis.set(:exchange_rate, data.to_json)
  end

  def redis
    Redis.new
  end

  def connection
    Faraday.new(url: 'https://api.cryptonator.com')
  end
end
