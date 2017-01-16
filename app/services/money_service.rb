module MoneyService extend self

  def format(number, currency)
    "#{currency_prefix(currency)}#{'%.2f' % number}"
  end

  private

  def currency_prefix(currency)
    case currency
    when 'usd'
      "$"
    when 'eur'
      "€"
    end
  end
end
