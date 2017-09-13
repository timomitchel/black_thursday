require "./lib/sales_engine"
require "./lib/math"
# require "pry"

class SalesAnalyst
  include Math

   attr_reader :engine

   def initialize(engine)
     @engine = engine
   end

   def average_items_per_merchant
     items = all_items
     merchants = all_merchants
    (items.to_f / merchants.to_f).round(2)
   end

   def average_items_per_merchant_standard_deviation
     count = 0
     mean = 0
     engine.merchants.all.each do |merchant|
       count += 1
       mean += (merchant.items.length - average_items_per_merchant)**2
     end
     Math.sqrt(mean.to_f / (count - 1)).round(2)
   end

   def merchants_with_high_item_count
     total = one_standard_deviation
     high_sellers = engine.merchants.all.select do |merchant|
       merchant.items.length >= total
     end
     high_sellers.count
   end

   def average_item_price_for_merchant(merchant_id)
     items = engine.items.find_all_by_merchant_id(merchant_id)
     average = 0.00
     items.each {|item| average += item.unit_price.to_f}
     (average / items.count).round(2)
   end

   def average_average_price_per_merchant
     average = engine.merchants.all.map do |merchant|
       average_item_price_for_merchant(merchant.id)
     end
     (average.sum.to_f / average.length.to_f).round(2)
   end

   def golden_items
     average = average_average_price_per_merchant
     items = engine.items.all
     mean = items.map do |item|
       (item.unit_price - average)**2
     end
     stnd_dev = Math.sqrt(mean.reduce(:+)/(items.count - 1)).round(2)
     total = average + (stnd_dev * 2).round(2)
     golden_items = items.select do |item|
       item.unit_price >= total
     end
     golden_items.count
   end

end
