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

  def average_invoices_per_merchant
    (engine.invoices.all.count.to_f / engine.merchants.all.count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    mean = engine.merchants.all.map do |merchant|
      (merchant.invoices.length - average_invoices_per_merchant)**2
    end
    Math.sqrt(mean.sum / (engine.merchants.all.count - 1)).round(2)
  end

end
