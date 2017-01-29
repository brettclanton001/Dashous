module MoneyService extend self

  def format(number, currency)
    "#{currency_prefix(currency)}#{format_number(number)}#{currency_suffix(currency)}"
  end

  private

  def format_number(number)
    if number < 1000
      '%.2f' % number
    else
      number.floor
    end
  end

  def currency_prefix(currency)
    case currency
    when 'usd', 'aud', 'cad', 'nzd'
      '$'
    when 'cny'
      '¥'
    when 'eur'
      '€'
    when 'gbp'
      '£'
    when 'jpy'
      '¥'
    when 'myr'
      'RM'
    else
      ''
    end
  end

  def currency_suffix(currency)
    case currency
    when 'chf'
      ' Fr.'
    when 'czk'
      ' Kč'
    when 'kes'
      ' KSh'
    when 'pln'
      ' zł'
    when 'rub'
      ' ₽'
    when 'sek'
      ' kr'
    when 'tzs'
      ' TSh'
    else
      ''
    end
  end
end
