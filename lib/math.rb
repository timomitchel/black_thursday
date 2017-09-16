require 'pry'
module Math
  def all_merchants
    engine.merchants.all.count
  end

  def all_items
    engine.items.all.count
  end

  def one_standard_deviation
    average_per_item = average_items_per_merchant
    stnd_dev = average_items_per_merchant_standard_deviation
    (average_per_item + stnd_dev).ceil
  end

end
