require_relative "sales_engine"
require_relative "math"
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
     Math.sqrt(mean.sum / (engine.merchants.all.count - 1)).round(2)
   end

   def merchants_with_high_item_count
     total = one_standard_deviation
     high_sellers = engine.merchants.all.select do |merchant|
       merchant.items.length >= total
     end
     high_sellers
   end

   def average_item_price_for_merchant(merchant_id)
     items = engine.items.find_all_by_merchant_id(merchant_id)
     average = 0.00
     items.each {|item| average += item.unit_price}
     (average / items.count).round(2)
   end

   def average_average_price_per_merchant
     average = engine.merchants.all.map do |merchant|
       average_item_price_for_merchant(merchant.id)
     end
     (average.sum / average.length).round(2)
   end

   def golden_items
     average = average_average_price_per_merchant
     items = engine.items.all
     mean = items.map {|item|(item.unit_price - average)**2}
     stnd_dev = Math.sqrt(mean.reduce(:+)/(items.count - 1)).round(2)
     total = average + (stnd_dev * 2).round(2)
     golden_items = items.select {|item| item.unit_price >= total}
     golden_items
   end

   def average_invoices_per_merchant
     (engine.invoices.all.count.to_f / engine.merchants.all.count.to_f).round(2)
   end

   def average_invoices_per_merchant_standard_deviation
     mean = engine.merchants.all.map do |merchant|
       (merchant.invoices.length - average_invoices_per_merchant)**2
     end
     Math.sqrt(mean.sum / (engine.merchants.all.count - 1)).round(2)
   end

   def top_merchants_by_invoice_count
     average = average_invoices_per_merchant
     stnd_dev = average_invoices_per_merchant_standard_deviation
    total = (average + (stnd_dev * 2)).round(2)
    high_sellers = engine.merchants.all.select do |merchant|
      merchant.invoices.length >= total
    end
    high_sellers
   end

   def bottom_merchants_by_invoice_count
    average = average_invoices_per_merchant
    stnd_dev = average_invoices_per_merchant_standard_deviation
    total = (average - (stnd_dev * 2)).round(2)
    bottom_sellers = engine.merchants.all.select do |merchant|
      merchant.invoices.length <= total
    end
    bottom_sellers
   end

   def top_days_by_invoice_count
     days = engine.invoices.all.map{|invoice| invoice.created_at.strftime("%A")}
     week = days.uniq
     amount = week.map {|day| days.count(day)}
     amount_of_days = week.zip(amount)
     average = amount.sum / 7
     mean = amount.map {|num| (num - average)**2}
     stnd_dev = Math.sqrt(mean.sum.to_f / amount.length).ceil
     total = average + stnd_dev
     day = amount_of_days.select {|day| day[1] > total}
     [] << day[0][0]
   end

   def invoice_status(input)
     all = engine.invoices.all.select do |invoice|
       invoice.status == input
     end
     ((all.count.to_f / engine.invoices.all.count) * 100).round(2)
   end

end
