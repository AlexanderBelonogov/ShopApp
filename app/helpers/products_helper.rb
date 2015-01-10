module ProductsHelper
  def fetch_cart_details
    if cookies[:cart].present? 
      card_data = JSON.parse(cookies[:cart])
      [JSON.parse(cookies[:cart]).size, JSON.parse(cookies[:cart]).map{|i| i['price']}.inject(:+)]
    else
      [0,0]
    end
  end
end