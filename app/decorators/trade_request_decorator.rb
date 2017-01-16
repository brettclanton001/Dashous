class TradeRequestDecorator < Draper::Decorator
  delegate_all

  def intention
    "#{object.kind}ing"
  end

  def sale_price
    case object.kind
    when 'buy'
      format_price(current_price * (1 - profit_margin))
    when 'sell'
      format_price(current_price * (1 + profit_margin))
    end
  end

  def map_location
    "#{object.latitude}, #{object.longitude}"
  end

  def offer_possible(user)
    return false if user.nil?
    return false if user == object.user
    user.offers.where(trade_request_id: object.id, status: [:pending, :declined]).empty?
  end

  def offer_restricted_reason(user)
    return 'Please login to make an offer.' if user.nil?
    return 'This is your Trade Request.' if user == object.user
    return 'Offer pending...' if user.offers.where(trade_request_id: object.id, status: :pending).exists?
    return 'Offer declined.' if user.offers.where(trade_request_id: object.id, status: :declined).exists?
  end

  private

  def format_price(price)
    "#{currency_prefix}#{'%.2f' % price}"
  end

  def currency_prefix
    case object.currency
    when 'usd'
      "$"
    when 'eur'
      "€"
    end
  end

  def current_price
    ExchangeRateService.current_price
  end

  def profit_margin
    object.profit.to_f / 100
  end
end
