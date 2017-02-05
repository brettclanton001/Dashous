module MoneyService extend self

  CURRENCY_DATA = YAML.load_file("#{Rails.root}/config/currencies.yml").with_indifferent_access.freeze

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
    CURRENCY_DATA[currency][:prefix]
  end

  def currency_suffix(currency)
    if suffix = CURRENCY_DATA[currency][:suffix]
      " #{suffix}"
    end
  end
end
