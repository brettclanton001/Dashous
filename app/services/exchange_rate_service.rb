module ExchangeRateService extend self

  CURRENCIES = %w(
    usd
    aud
    cad
    cny
    eur
    gbp
    jpy
    myr
    nzd
    pln
    rub
  ).freeze

  CACHE_TIMEOUT = 15.minutes.freeze

  def current_price(currency='usd')
    external_data[currency]
  end

  private

  def external_data
    cache = get_cache
    return cache if cache_valid?(cache)
    fetch_external_data
  end

  def fetch_external_data
    data = {}

    currencies = CURRENCIES.map { |currency| currency.upcase }.join(',')
    external_data = JSON.parse connection.get("/data/price?fsym=DASH&tsyms=#{currencies}").body

    CURRENCIES.each do |currency|
      data[currency] = external_data[currency.upcase].to_f.round(2)
    end

    data['updated_at'] = Time.now
    set_cache(data)
    data
  end

  def cache_valid?(cache)
    cache.present? and cache['updated_at'] > Time.now - CACHE_TIMEOUT
  end

  def get_cache
    cache = $redis.get(:exchange_rate)
    cache = JSON.parse(cache) if cache.present?
    cache
  end

  def set_cache(data)
    $redis.set(:exchange_rate, data.to_json)
  end

  def connection
    Faraday.new(url: 'https://min-api.cryptocompare.com')
  end
end
