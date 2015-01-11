module ProductsHelper
  def build_currency(number)
    number_to_currency(number, unit: "$", separator: ",", delimiter: "", format: "%n %u")
  end
end