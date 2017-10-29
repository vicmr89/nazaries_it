require 'open-uri'
require 'nokogiri'
require 'json'

url = 'https://www.port-monitor.com/plans-and-pricing'
html = open(url)
doc = Nokogiri::HTML(html)
products = []
doc.css('.product').each do |product|
  monitors_number = product.css('h2').text.strip
  check_rate_var = product.css('.thin dd').first.text.strip.split(' ')[1]
  history_var = product.css('.thin dd')[1].text.strip.split(' ')[0]
  multiple_notifications_var = product.css('.thin dd span').first.text.strip
  push_notifications_var = product.css('.thin dd span')[1].text.strip
  price_var = product.at_css('.btn-large').text.split(' ')[0]
  products.push(
    monitors: monitors_number,
    check_rate:check_rate_var,
    history:history_var,
    multiple_notifications: multiple_notifications_var,
    push_notifications: push_notifications_var,
    price: price_var
  )
end

puts JSON.pretty_generate(products)
