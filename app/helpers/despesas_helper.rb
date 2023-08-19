module DespesasHelper
  def positive_negative_style(value)
    if value.positive?
      'color:red; font-size:20px;'
    else
      'color:green; font-size:20px;'
    end
  end

  def formatted_date(date)
    date.strftime('%b %e, %Y')
  end

  def formatted_decimal(value)
    number_with_precision(value, precision: 2, delimiter: I18n.t('number.format.delimiter'), separator: I18n.t('number.format.separator'))
  end
end
