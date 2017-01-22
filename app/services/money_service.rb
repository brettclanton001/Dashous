module MoneyService extend self

  def format(number, currency)
    "#{currency_prefix(currency)}#{'%.2f' % number}"
  end

  private

  def currency_prefix(currency)
    case currency
    when 'gbp'
      "£"
    when 'cad'
      "$"
    when 'cny'
      "¥"
    when 'eur'
      "€"
    when 'jpy'
      "¥"
    when 'myr'
      "RM"
    when 'pln'
      "zł"
    when 'rub'
      "₽"
    when 'usd'
      "$"
    end
  end
end
