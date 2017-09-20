require 'pry'
module MerchantAnalyst
  def total_revenue_by_date(date)
    all = engine.invoices.all.select do |invoice|
      invoice.created_at == date
    end
   all.reduce(0) {|sum, invoice| sum += invoice.total}
  end

  def top_revenue_earners(x = 20)
    top_merchants
    all = []
    x.times {|index| all << top_merchants[index][0]}
    all
  end

  def top_merchants
    merchants = engine.merchants.all.select do |merchant|
       merchant.invoices.count > 0
    end
    top = merchants.map{|merchant| [merchant, revenues(merchant.id)]}
    top = top.sort_by {|merchant| merchant[1]}.reverse
  end

  def merchants_ranked_by_revenue
    top_merchants.map {|merchant| merchant[0]}
  end

  def revenues(id)
    revenue = engine.merchants.find_by_id(id).revenue.to_f.round(2)
  end

  def merchants_with_pending_invoices
    total = engine.invoices.all.select do |invoice|
      !invoice.is_paid_in_full?
    end
    total.map{|invoice| engine.merchants.find_by_id(invoice.merchant_id)}.uniq
  end

  def merchants_with_only_one_item
    one_item
  end

  def merchants_with_only_one_item_registered_in_month(month)
    one_item.select do |merchant|
      merchant.created_at.month == Date::MONTHNAMES.index(month)
    end
  end

  def one_item
    singles = engine.merchants.all.find_all do |merchant|
      merchant.has_one_item?
    end
  end

  def revenue_by_merchant(merchant_id)
    engine.merchants.find_by_id(merchant_id).revenue
  end

  def most_sold_item_for_merchant(merchant_id)
    invoices = engine.invoices.find_all_by_merchant_id(merchant_id)
    all = invoices.select {|invoice| invoice.is_paid_in_full?}
    total = all.map {|invoice| invoice.invoice_items}
    turn_to_items(top_items(total))
  end

  def top_items(total)
    max = total.flatten.max_by {|invoice_item| invoice_item.quantity}
    top_items = total.flatten.select do |invoice_item|
      invoice_item.quantity == max.quantity
    end
  end

  def turn_to_items(top_item)
    top_item.flatten.map do |invoice_item|
       engine.items.find_by_id(invoice_item.item_id)
    end
  end

  def best_item_for_merchant(id)
    merchant = engine.merchants.find_by_id(id)
    merchant_items = merchant.items
    merchant_invoices = merchant.invoices.select{|inv| inv.is_paid_in_full?}
    items = merchant_invoices.map {|invoice| invoice.invoice_items}.flatten
    items = items.map {|invoice| [invoice.item_id, invoice.price]}
    item = items.max_by{|invoice| invoice[1]}
    engine.items.find_by_id(item[0])
  end
end
