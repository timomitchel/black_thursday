require_relative "sales_engine"
require_relative "math"
require_relative "merchant_analyst"
require "pry"

class SalesAnalyst
  include Math
  include MerchantAnalyst

   attr_reader :engine

   def initialize(engine)
     @engine = engine
   end

   def average_items_per_merchant
     items = all_items
     merchants = all_merchants
     (items.to_f / merchants.to_f).round(2)
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
       invoice.status.to_sym == input
     end
     ((all.count.to_f / engine.invoices.all.count) * 100).round(2)
   end

   def total_revenue_by_date(date)
     all = engine.invoices.all.select do |invoice|
       invoice.created_at == date
     end
    all.reduce(0) {|sum, invoice| sum += invoice.total}
   end

   def top_revenue_earners(x = 20)
    merchants = engine.merchants.all.select do |merchant|
       merchant.invoices.count > 0
    end
    top = merchants.map{|merchant| [merchant, revenues(merchant.id)]}
    top = top.sort_by {|merchant| merchant[1]}.reverse
    all = []
    x.times {|index| all << top[index][0]}
    all
   end

   def revenues(id)
     revenue = engine.merchants.find_by_id(id).revenue.to_f.round(2)
   end


end
