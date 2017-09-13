require "./lib/sales_engine"
require "./lib/math"
require "pry"

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
     mean = engine.merchants.all.map do |merchant|

      (merchant.items.length - average_items_per_merchant)**2
      end
    Math.sqrt(mean.reduce(:+)/(engine.merchants.all.count - 1)).round(2)
   end

   def merchants_with_high_item_count
     total = (average_items_per_merchant + average_items_per_merchant_standard_deviation).ceil
     high_sellers = engine.merchants.all.select do |merchant|
       merchant.items.length >= total
     end
     high_sellers
   end

   def average_item_price_for_merchant(merchant_id)

   end

   def average_average_price_per_merchant

   end

   def golden_items

   end

end

se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})

sa = SalesAnalyst.new(se)
puts sa.merchants_with_high_item_count
