class TradeRequestDecorator < Draper::Decorator
  delegate_all

  def intention
    "#{object.kind}ing"
  end

  def sale_price
    case object.kind
    when 'buy'
      current_price * (1 - profit_margin)
    when 'sell'
      current_price * (1 + profit_margin)
    end
  end

  def map_location
    "#{object.latitude}, #{object.longitude}"
  end

  private

  def current_price
    PriceService.current_price
  end

  def profit_margin
    object.profit.to_f / 100
  end
end
