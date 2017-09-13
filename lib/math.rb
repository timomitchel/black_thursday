module Math
  def all_merchants
    engine.merchants.all.count
  end

  def all_items
    engine.items.all.count
  end

  def items_and_merchants_total_and_squared


  end

  def standard_deviation
    total = engine.merchants.all
    total.map {|m| engine.items.find_by_merchant_id(m.id)}

  end

  def high_standard_deviation
    average = (items.to_f / merchants.to_f).round(2)

  end


end
