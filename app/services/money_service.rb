module MoneyService extend self

  def format(number, currency)
    "#{currency_prefix(currency)}#{format_number(number)}#{currency_suffix(currency)}"
  end

  private

  def format_number(number)
    '%.2f' % number
  end

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
    else
      ""
    end
  end

  def currency_suffix(currency)
    case currency
    when 'czk'
      " Kč"
    when 'pln'
      " zł"
    when 'rub'
      " ₽"
    else
      ""
    end
  end
end
