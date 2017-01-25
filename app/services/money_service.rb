module MoneyService extend self

  def format(number, currency)
    "#{currency_prefix(currency)}#{'%.2f' % number}"
  end

  private

  def currency_prefix(currency)
    case currency
    when 'usd', 'aud', 'cad', 'nzd'
      "$"
    when 'cny'
      "¥"
    when 'eur'
      "€"
    when 'gbp'
      "£"
    when 'jpy'
      "¥"
    when 'myr'
      "RM"
    when 'pln'
      "zł"
    when 'rub'
      "₽"
    end
  end
end
