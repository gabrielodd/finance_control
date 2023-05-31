module DespesasHelper
  def positive_negative_style(value)
    if value.positive?
      'color:red; font-size:20px;'
    else
      'color:green; font-size:20px;'
    end
  end
end
